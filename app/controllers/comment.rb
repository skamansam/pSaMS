PSaMs::App.controllers :comments do

   get :index, params: [:post_id] do
     render 'index'
   end

   get :show, params: [:id] do
     @comment = CommentPresenter.new(Comment.find_by_id(params[:id]))
     render 'show'
   end

   post :create, provides: [:json], params: [:comment, :post_id] do
     i = CommentInteractor::Create.new(params[:comment])
     if i.perform
       { message: 'saved comment', html: (partial('comments/comment', object: CommentPresenter.new(i.comment)))}.to_json
     else
       { message: i.errors }.to_json
     end
   end

end
