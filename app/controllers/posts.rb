#menu de postss
get '/posts' do
  # La siguiente linea hace render de la vista 
  # que esta en app/views/index.erb
  erb :menu_post
end

#Muestra todos los posts
get '/posts/show_all' do
  @all_posts = Post.all
  erb :show_all
end

#muestra el post seleccionado
get '/posts/show_one' do
  @all_posts = Post.all
  erb :show_one
end
post '/posts/show_one/show' do
  @one_selected = params[:select]
  erb :show_by_one
end

#crea un post
get '/posts/create_post' do
  erb :create_post
end

post '/posts/create_post/post_created' do  
  tags = params[:tags].split(" ")
  @post_new = Post.create(title: params[:title], description: params[:description])
  tags.each do |t|
  tag = Tag.find_by(label: t)

    if tag != nil
      PostTag.create(post_id: @post_new.id, tag_id: tag.id)
    else
      tag_new = Tag.create(label: t)
      PostTag.create(post_id: @post_new.id, tag_id: tag_new.id)
    end
  end
  @post_new
  erb :post_created
end

#Edita un post
get '/posts/edit_post' do
  erb :edit_post
end

post '/posts/edit_post/edit' do
  @edit_post = params[:select]
  erb :post_edited
end


##update de post editado
post '/posts/edit_post/edit/create_edit' do
  @id_post = params[:id]
  post_update = Post.find_by(id: @id_post)
  post_update.update(title: params[:title], description: params[:description])
  p tags = params[:label].split(" ")
  array_tags = []
  array_tags_2 = []
  tag_new_1 = Post.find_by(id: @id_post).tags

  tag_new_1.each do |t|
      array_tags << t.label
      array_tags_2 << t
  end

  if array_tags == tags

  else
    tags.each do |tag_2|
      if array_tags.include?(tag_2)
      else
        tag = Tag.find_by(label: tag_2)
        if tag == nil 
          tag_new = Tag.create(label: tag_2)
          PostTag.create(post_id: post_update.id, tag_id: tag_new.id)
        else
          tag_new = Tag.create(label: tag_2)
          PostTag.create(post_id: post_update.id, tag_id: tag_new.id)
        end
      end
      array_tags.delete(tag_2)
    end
  end
  array_3 = []

  array_tags_2.each do |t|
    if array_tags.include?(t.label)
      array_3 << t 
    else
    end
  end
  array_3
  array_3.each do |tag|
    p tag.destroy
  end

  
  erb :post_editado
end

##borra post

get '/posts/delete_post' do
  erb :delete_post
end
post '/posts/delete_post/delete' do
  PostTag.where(id: params[:select].keys).destroy_all 
  @all_posts = Post.all
  @deleted_post = params[:select]
  erb :post_deleted
end
