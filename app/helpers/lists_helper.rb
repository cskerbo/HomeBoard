module ListsHelper

  def create_list_widget(home)
    @home = Home.find(home)
    @home.lists.build(name: "New List")
    @home.save
  end

end