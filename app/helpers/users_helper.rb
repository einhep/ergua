module UsersHelper
  def einhep_get_image(user)
    #users images
    image_tag("/assets/default.jpg",alt:user.name,class:"gravatar")
  end

end
