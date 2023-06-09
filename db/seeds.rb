# frozen_string_literal: true

# create a category
Category.create(title: 'Default',
                description: 'Here your description',
                meta_title: 'Default',
                meta_description: 'Description category',
                meta_keywords: 'category, meta, keywords')

# create a post
Post.create(category: Category.all.first,
            title: 'Hello world!',
            body: 'Here your content',
            published: true,
            description: 'Here your description',
            meta_title: 'Hello world!',
            meta_description: 'Description Hello world!',
            meta_keywords: 'hello, world, description')

# create a page
Page.create(title: 'About',
            body: 'Here your content',
            published: true,
            meta_title: 'About',
            meta_description: 'Description page about',
            meta_keywords: 'abaout, meta, description')

# create an admin account
AdminUser.create!(email: 'admin@admin.com',
                  password: 'password',
                  password_confirmation: 'password')
