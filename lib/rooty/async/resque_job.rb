module Rooty
  module Async
    
    class ResqueJob
      @queue = :file_serve

      def self.perform(repo_id, branch = 'master')
        puts "perform called #{repo_id}"
        # repo = Repository.find(repo_id)
        # repo.create_archive(branch)
      end
    end
    
  end
end