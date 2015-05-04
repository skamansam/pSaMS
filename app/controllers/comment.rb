PSaMs::Photos.controllers :comment do

   get :index, map: '/posts/:post_id/comments', params: [:post_id] do
     render 'index'
   end

   # maps to /comments/#{id}
   get :comments, map: '/posts/:post_id/comments/:id', params: [:post_id, :id] do
     @comment = Post.find_by_id(params[:post_id]).try(Comment.find_by_id(params[:id]))
     render 'show'
   end

end
