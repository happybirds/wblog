require 'spec_helper'

describe BlogsController do

  it 'index should get by order desc' do
    a = Post.new(title: 'a123', content: '123'*20, type: Post::TECH)
    a.save!

    b = Post.new(title: 'b1234', content: '123'*20,type: Post::TECH)
    b.save!

    c = Post.new(title: 'c1234', content: '123'*20,type: Post::TECH)
    c.save!

    d = Post.new(title: 'd1234', content: '123'*20,type: Post::TECH)
    d.save!

    a.update(title: 'aaa')
    get :index
    assigns[:newest].title.should == d.title
    assigns[:recent][0].title.should == c.title
    assigns[:recent][1].title.should == b.title

  end

  it 'test show method' do
    post = Post.new(title: 'a123', content: '123'*20, type: Post::TECH)
    post.save!
    a = Comment.new(name: '1',content: '2432423',email: '22@.com')
    a.post = post
    a.save!
    b = Comment.new(name: '2',content: 'iloveyou',email: 'liuzhen@.com')
    b.post = post
    b.save!
    get :show, id: post.id
    assigns[:comments][0].name.should == '1'
    assigns[:comments][0].content.should == '2432423'
    assigns[:comments][0].email.should == '22@.com'
    assigns[:comments][1].name.should == '2'
    assigns[:comments][1].content.should == 'iloveyou'
    assigns[:comments][1].email.should == 'liuzhen@.com'
  end

  it 'test show method' do
    post = Post.new(title: 'a123', content: '123'*20, type: Post::TECH)
    post.save!
    a = Comment.new(name: '1',content: '2432423',email: '22@.com')
    a.post = post
    a.save!
    b = Comment.new(name: '2',content: 'iloveyou',email: 'liuzhen@.com')
    b.post = post
    b.save!
    label = Label.new(type: '生活')
    post.labels << label
    post.save!
    get :show, id: post.id
    assigns[:comments][0].name.should == '1'
    assigns[:comments][0].content.should == '2432423'
    assigns[:comments][0].email.should == '22@.com'
    assigns[:comments][1].name.should == '2'
    assigns[:comments][1].content.should == 'iloveyou'
    assigns[:comments][1].email.should == 'liuzhen@.com'
  end

  describe "get SHOW" do
    it "#prev, #next" do
      posts = create_list(:post_list, 3)
      selected = posts[1]
      s_prev = posts[2]
      s_next = posts[1]
      get :show, id: selected.id
      expect(assigns(:prev)).to eq(s_prev)
      expect(assigns(:next)).to eq(s_next)

      selected = posts[2]
      get :show, id: selected.id
      expect(assigns(:prev)).to be_nil
      expect(assigns(:next)).to eq(posts[1])

      selected = posts[0]
      get :show, id: selected.id
      expect(assigns(:prev)).to eq(posts[1])
      expect(assigns(:next)).to be_nil

    end
  end
end
