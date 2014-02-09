---
layout: post
title: "Stub that object"
---

There's this common thought that stubbing the object under test is _always_ punishable by death. I'd like to dispel this nonsense.

When writing unit tests against objects that have inherited methods--you know, pretty much every object in rails--it's sometimes necessary to stub the object under test. Let's check out an example.

Assume we're building an app for a custom inflatable coffee table business. We would probably have an `InflatableCoffeeTablePurchases` controller. Maybe it would look like this:

{% highlight ruby %}
class InflatableCoffeeTablePurchasesController < ApplicationController
  def create
    if current_user
      CreateInflatableCoffeeTableOrder.new(current_user).execute
    else
      redirect_to sign_up_sucka_path
    end
  end
end
{% endhighlight %}

Yes indeed, this thing is looking good! You'll notice we're using a few methods that we didn't define here, but are local to our object: current_user, redirect_to, and sign_up_sucka_path. So when we write a unit test for this thing, we'll need to mock or stub these methods. In rspec, that should look something like this:

{% highlight ruby %}
describe InflatableCoffeeTablePurchasesController do
  let(:controller) { InflatableCoffeeTablePurchasesController.new }

  before do
    controller.stub(:current_user) { current_user }
    CreateInflatableCoffeeTableOrder.stub(:new) { command }
  end

  describe "#create" do
    context "current_user exists" do
      let(:current_user) { true }

      it "creates an inflatable coffee table order" do
        expect(command).to receive(:execute)
        controller.create
      end
    end

    context "current_user does not exist" do
      let(:current_user) { false }
      let(:sign_up_sucka_path) { double(:sign_up_sucka_path) }

      before do
        controller.stub(:sign_up_sucka_path) { sign_up_sucka_path }
      end

      it "redirects to sign_up_sucka_path" do
        expect(controller).to_receive(:redirect_to).with(sign_up_sucka_path)
      end
    end
  end
end
{% endhighlight %}

So there you have it. Unless you want to write integrationy "unit" tests, you'll sometimes need to stub the object under test. And this doesn't make you an awful person. I'm sure of it.
