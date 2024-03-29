ActiveAdmin.register Comment do
  permit_params :body,
                :published,
                :post_id,
                :user_id

  batch_action :publish do |ids|
    Comment.where(id: ids).update_all(published: true)
    redirect_to admin_comments_path, notice: 'Comment(s) was published'
  end

  batch_action :not_publish do |ids|
    Comment.where(id: ids).update_all(published: false)
    redirect_to admin_comments_path, notice: 'Comment(s) was not published'
  end

  index do
    selectable_column
    column :user
    column :body
    column :post
    column :published
    column :created_at
    actions
  end

  filter :published
  filter :body
  filter :post
  filter :user#, collection: User.all.map { |u| [u.email, u.id] }
  filter :updated_at
  filter :created_at

  form do |f|
    f.inputs 'Attached' do
      f.semantic_errors
      f.input :post
      f.input :user#, collection: User.all.map { |u| [u.email, u.id] }
    end

    f.inputs 'Content' do
      f.semantic_errors
      f.input :body
      f.input :published
    end

    f.actions
  end
end
