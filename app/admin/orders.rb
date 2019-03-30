ActiveAdmin.register Order do

permit_params :status, :user_id, :delivery_id
# includes :delivery

end
