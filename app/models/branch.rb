class Branch
  class << self

    def notify_when_merged(base_repo, base_branch_name, head_branch_name)
      p `growlnotify -s -t "#{base_repo}/#{base_branch_name}" -m "has been updated (branch #{head_branch_name} was merged into it)"`
    end

    def in_watch_list?(repo_full_name, branch)
      watch_list = YAML.load_file("config/watch_list.yml")
      watch_list.any? {|w| w[:repo] == repo_full_name && w[:branch] == branch}
    end

    def update(message_hsh)
      warn "==== message_hsh: #{message_hsh}"
      pull_request_info = message_hsh[:params][:pull_request]

      if pull_request_info && "closed" == pull_request_info[:state] && pull_request_info[:merged]
        base_repo        = pull_request_info[:base][:repo][:name]
        base_repo_full_name = pull_request_info[:base][:repo][:full_name]
        base_branch_name = pull_request_info[:base][:ref]
        head_branch_name = pull_request_info[:head][:ref]
        notify_when_merged(base_repo, base_branch_name, head_branch_name) if in_watch_list?(base_repo_full_name, base_branch_name)

      # TODO: based on the message_hsh's params from the github hook payloads
      # we can add more cases here: when a branch created/deleted, when new commit,
      # when there is a new pull request...
      # elsif...

      else
        p `growlnotify -s -t "minh" -m "is awesome. but nothing important has happened yet."`
      end

    end
  end
end