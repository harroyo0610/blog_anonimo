get '/tags' do
  erb :menu_tag
end

post "/tags/tag_name" do
  tag_user = params[:tag_name]
  @tags_list = Tag.where(label: tag_user)
  erb :show_tag
end
