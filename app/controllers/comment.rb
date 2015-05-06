PSaMs::App.controllers :comment do

   get :index, map: '/posts/:post_id/comments', params: [:post_id] do
     render 'index'
   end

   # maps to /comments/#{id}
   get :show, map: '/posts/:post_id/comments/:id', params: [:post_id, :id] do
     @comment = Post.find_by_id(params[:post_id]).try(Comment.find_by_id(params[:id]))
     render 'show'
   end

   post :create, map: '/posts/:post_id/comments', provides: [:json], params: [:post_id, :post] do
     i = CommentInteractor::Create.new(params[:post_id],params[:post])
     if i.perform
       {message: 'saved comment'}
     else
       {message: i.errors}
     end
   end

end
