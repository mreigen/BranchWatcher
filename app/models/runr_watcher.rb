require 'runr'

class RunrWatcher
  extend Runr

  runr_authorized_tasks  :update
  runr_authorized_topics :branch

  TOPIC_MAP = {
    # 'repo'   => Repo,
    'branch' => Branch
  }

  TASK_MAP = {
    'update' => 'update'
  }

  @channel_name = channel_name

  class << self
    # @param [Hash] message_hsh The hash that comprises the Runr message
    #   received by the CMS app
    #
    # Routes Runr messages.
    # Returns an error if the message is invalid in any way.
    # Otherwise, calls a class method in the appropriate model
    # and either sends an error or a callback, or delegates follow-up
    # to the class method called depending on the return value of the class method.
    #
    # @example
    #   RunrWatcher.runr_command({ topic: 'content', task: 'delete', params: { id: '123456' } }) #=> (deletes the ContentItem with ID '123456')
    def runr_command(message_hsh, context_hsh = {})
      warn "received request: #{message_hsh}"

      send_to = message_hsh[:reply_to] ? message_hsh[:reply_to] : message_hsh[:sent_to]

      # check the topic value is in the TOPIC_MAP and maps to a class
      if TOPIC_MAP[message_hsh[:topic]].is_a?(Class)
        # use the topic value to route to the appropriate class
        data_with_results = TOPIC_MAP[message_hsh[:topic]].send(TASK_MAP[message_hsh[:task]], message_hsh)
      else
        # call the method in the action field of the data hash directly
        data_with_results = self.send(message_hsh[:task], message_hsh)
      end

      generic_response_data = {
        sender: channel_name,
        sent_to: send_to,
        timestamp: Time.now
      }

      if data_with_results.is_a?(Hash) && data_with_results.key?(:error)
        # return an error message to the sender
        response = message_hsh.merge(generic_response_data).
          merge(data_with_results).
          merge({
            data: {}
          })
        runr_send_error(response)
      elsif data_with_results
        # send a callback containing the data returned
        response = message_hsh.merge(generic_response_data).
          merge({
            data: data_with_results
          })
        runr_send_callback(response)
      else
        # Do nothing if results were nil (Runr follow-up delegated to model)
        return true
      end
    end

    def runr_callback(message_hsh, context_hsh)
      warn "received callback: #{message_hsh}"
    end

    def runr_feedback(message_hsh, context_hsh)
      warn "received feedback: #{message_hsh}"
    end

    def runr_error(message_hsh, context_hsh)
      warn "received error: #{message_hsh}"
    end

    def runr_ack(message_hsh, context_hsh = {})
      warn "received ack: #{message_hsh}"
    end

    # TODO: randomize channel_name initiallly
    # then save it to a yml file

    # def channel_name
    #   warn "=== @channel_name before: #{@channel_name}"
    #   @channel_name = "watcher_#{SecureRandom.hex(4)}" if "watcher" == @channel_name
    #   warn "=== @channel_name after: #{@channel_name}"
    #   @channel_name
    # end

    def build_sent_to_server_message(branch_name)
      {
        sent_to: "watcherserver",
        params: {
          channel_name: channel_name,
          branch_name:  branch_name
        }
      }
    end

    def my_listen(my_channel_name)
      runr_listen(my_channel_name, {
        timeout_at:         60,
        timeout_force_stop: false,
        threaded:           true
      })
    end

    def subscribe(opts = {})
      file_name = "watcher_id.txt"
      if File.exists?(file_name)
        self.channel_name = File.readlines(file_name)[0].gsub("\n", "")
      else
        self.channel_name = "watcher_#{SecureRandom.hex(4)}"
        File.open(file_name, "w") { |f| f.puts self.channel_name }
      end
      self.runr_send_request(build_sent_to_server_message(opts[:branch_name]).merge(task: "subscribe", topic: "branch"))
      self.my_listen(channel_name)
    end

    def unsubscribe(opts = {})
      runr_send_request(build_sent_to_server_message(opts[:branch_name]).merge(task: "unsubscribe", topic: "branch"))
    end

  end

  # start_listening

  # subscribe({branch_name: "some_branch_to_watch"})

end
