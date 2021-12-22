class PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_conversation

  # rubocop:disable Metrics/MethodLength
  def create
    @post = @conversation.posts.build(post_params.merge(author: current_user))

    respond_to do |format|
      if @post.save
        format.turbo_stream {
          render(turbo_stream: turbo_stream.replace(
            'form',
            partial: 'posts/form',
            locals: { conversation: @conversation, post: Post.new }
          ))
        }
      else
        format.turbo_stream {
          render(turbo_stream: turbo_stream.replace(
            'form',
            partial: 'posts/form',
            locals: { conversation: @conversation, post: @post }
          ))
        }
      end
    end
  end
  # rubocop:enable Metrics/MethodLength

  private

  def set_conversation
    @conversation = Conversation.find(params[:conversation_id])
  end

  def post_params
    params.require(:post).permit(:body)
  end
end
