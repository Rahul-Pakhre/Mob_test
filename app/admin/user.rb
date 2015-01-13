ActiveAdmin.register User do
  index do
    column :username
    column :email
    column :Dob
    column "Create Date", :created_at
    actions
  end  


  index :as => :grid, :default => true do |user|
    link_to(image_tag(user.image_url(:thumb)), admin_user_path(user)) unless user.image.nil?
  end
end

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # permit_params :list, :of, :attributes, :on, :model
  #
  # or
  #
  # permit_params do
  #   permitted = [:permitted, :attributes]
  #   permitted << :other if resource.something?
  #   permitted
  # end


