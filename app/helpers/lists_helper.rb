module ListsHelper

  def create_list_widget(home)
    @home = Home.find(home)
    @home.lists.build(name: "")
    @home.save
  end

end