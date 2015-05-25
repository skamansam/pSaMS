module CommentInteractor
  class Create

    attr_reader :comment

    def initialize(options)
      @options = whitelisted_options(options)
    end
    def perform
      @comment = Comment.create!(@options)
    end

    private
    def whitelisted_options(opts)
      new_opts = {}
      [:body,:email,:title].each do |opt|
        new_opts[opt] = opts[opt.to_s] if opts.has_key?(opt.to_s)
      end
      if opts['post_id']
        new_opts[:comment_for_type] = 'Post'
        new_opts[:comment_for_id] = opts['post_id']
      end
      new_opts
    end
  end
end
