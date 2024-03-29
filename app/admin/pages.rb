ActiveAdmin.register Page do
  permit_params :meta_title,
                :meta_description,
                :meta_keywords,
                :title,
                :body,
                :published,
                :admin_user_id

  batch_action :publish do |ids|
    Page.where(id: ids).update_all(published: true)
    redirect_to admin_pages_path, notice: 'Page(s) was published'
  end

  batch_action :not_publish do |ids|
    Page.where(id: ids).update_all(published: false)
    redirect_to admin_pages_path, notice: 'Page(s) was not published'
  end

  index do
    selectable_column
    column :title
    column :admin_user
    column :published
    column :updated_at
    column :created_at
    actions
  end

  show do |page|
    panel 'Content' do
      page.body
    end

    attributes_table do
      row :meta_title
      row :meta_description
      row :meta_keywords
      row :admin_user
      row :published
      row :created_at
      row :updated_at
    end
  end

  filter :title
  filter :published
  filter :admin_user
  filter :created_at
  filter :updated_at

  form do |f|
    div do
      javascript_importmap_tags
    end

    f.inputs 'Attached' do
      f.semantic_errors
      f.input :admin_user
    end

    f.inputs 'Content' do
      f.semantic_errors
      f.input :title
      f.input :published
    end

    f.inputs 'Body' do
      f.semantic_errors
      li style: 'margin: 10px' do
        f.rich_text_area :body
      end
    end

    f.inputs 'Meta data' do
      f.semantic_errors
      f.input :meta_title
      f.input :meta_description
      f.input :meta_keywords
    end
    f.actions
  end
end
