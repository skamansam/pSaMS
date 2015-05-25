PSaMs::Admin.controllers :comments do
  get :index do
    @title = "Comments"
    @comments = Comment.all
    render 'comments/index'
  end

  get :new do
    @title = pat(:new_title, model: 'comment')
    @comment = Comment.new
    render 'comments/new'
  end

  post :create do
    @comment = Comment.new(params[:comment])
    if @comment.save
      @title = pat(:create_title, model: "comment #{@comment.id}")
      flash[:success] = pat(:create_success, model: 'Comment')
      params[:save_and_continue] ? redirect(url(:comments, :index)) : redirect(url(:comments, :edit, id: @comment.id))
    else
      @title = pat(:create_title, model: 'comment')
      flash.now[:error] = pat(:create_error, model: 'comment')
      render 'comments/new'
    end
  end

  get :edit, with: :id do
    @title = pat(:edit_title, model: "comment #{params[:id]}")
    @comment = Comment.find(params[:id])
    if @comment
      render 'comments/edit'
    else
      flash[:warning] = pat(:create_error, model: 'comment', id: "#{params[:id]}")
      halt 404
    end
  end

  put :update, with: :id do
    @title = pat(:update_title, model: "comment #{params[:id]}")
    @comment = Comment.find(params[:id])
    if @comment
      if @comment.update_attributes(params[:comment])
        flash[:success] = pat(:update_success, model: 'Comment', id:  "#{params[:id]}")
        params[:save_and_continue] ?
          redirect(url(:comments, :index)) :
          redirect(url(:comments, :edit, id: @comment.id))
      else
        flash.now[:error] = pat(:update_error, model: 'comment')
        render 'comments/edit'
      end
    else
      flash[:warning] = pat(:update_warning, model: 'comment', id: "#{params[:id]}")
      halt 404
    end
  end

  delete :destroy, with: :id do
    @title = "Comments"
    comment = Comment.find(params[:id])
    if comment
      if comment.destroy
        flash[:success] = pat(:delete_success, model: 'Comment', id: "#{params[:id]}")
      else
        flash[:error] = pat(:delete_error, model: 'comment')
      end
      redirect url(:comments, :index)
    else
      flash[:warning] = pat(:delete_warning, model: 'comment', id: "#{params[:id]}")
      halt 404
    end
  end

  delete :destroy_many do
    @title = "Comments"
    unless params[:comment_ids]
      flash[:error] = pat(:destroy_many_error, model: 'comment')
      redirect(url(:comments, :index))
    end
    ids = params[:comment_ids].split(',').map(&:strip)
    comments = Comment.find(ids)

    if Comment.destroy comments

      flash[:success] = pat(:destroy_many_success, model: 'Comments', ids: "#{ids.to_sentence}")
    end
    redirect url(:comments, :index)
  end
end
