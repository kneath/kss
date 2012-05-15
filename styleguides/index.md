---
layout: with-image
---

<a href="https://github.com/styleguide/css/1.0"><img src="/kss/images/styleguide_screenshot.png" class="page-image" /></a>

<p class="subdued">KSS is intended to help automate the creation of a living styleguide. A styleguide serves as a place to publish KSS documentation and visualize different states of UI elements defined in your CSS.</p>

It's sometimes hard to explain what a living styleguide is. The best way to explain is through examples. The [GitHub CSS Styleguide](https://github.com/styleguide/css) is a good example of a living styleguide generated with KSS. In particular, you can see the value of KSS on pages like the [buttons section](https://github.com/styleguide/css/1.0).

## Generating your own styleguide

Generating a styleguide with KSS is pretty easy with Rails, Sinatra or any other framework that you can include gems with.

<p class="warning">These instructions are for setting up a KSS styleguide with the <strong>Ruby</strong> programming language. Please keep in mind KSS is not a Ruby-only program! This is just <em>one possible</em> implementation of many.<br /><br />
  <a href="https://github.com/kneath/kss/issues/3">Help me write a binary generator to fix this!</a>
</p>

### In the controller

In the controller, create a new instance of the KSS parser like so:

{% highlight ruby %}
# Renders the css styleguide in accordance to KSS.
def styleguide
  @styleguide = Kss::Parser.new("#{RACK_ROOT}public/stylesheets")

  case params[:reference].to_i
  when 1.0
    render :template => "styleguide/css/buttons"
  when 2.0
    render :template => "styleguide/css/forms"
  when 3.0
    render :template => "styleguide/css/icons"
  end
end
{% endhighlight %}

Pass in the directory containing your stylesheets. It'll automatically recursively scan any CSS type files inside of the directory.

### In the views

I usually create a simple partial and view helper to render styleguide sections. So I'd create a partial called `_styleguide_block.html.erb` like so:

{% highlight erb %}
<div class="styleguide-example">

  <h3>
    <%= @section.section %>
  </h3>
  <div class="styleguide-description markdown-body">
    <p><%= markdown h(@section.description) %></p>
    <% if @section.modifiers.any? %>
      <ul class="styleguide-modifier">
        <% modifiers.each do |modifier| %>
          <li><strong><%= modifier.name %></strong> - <%= modifier.description %></li>
        <% end %>
      </ul>
    <% end %>
  </div>

  <div class="styleguide-element">
    <%= @example_html.gsub('$modifier_class', '').html_safe %>
  </div>
  <% modifiers.each do |modifier| %>
    <div class="styleguide-element styleguide-modifier">
      <span class="styleguide-modifier-name"><%= modifier.name %></span>
      <%= @example_html.gsub('$modifier_class', " #{modifier.class_name}").html_safe %>
    </div>
  <% end %>

  <div class="styleguide-html">
    <%= kss_block_html @example_html %>
  </div>

</div>
{% endhighlight %}

Then, I have a view helper that uses this partial:

{% highlight ruby %}
# For displaying a block documented with KSS.
#
# section - The name of the section to render.
#
# Returns nothing. Renders a string of HTML to the template.
def kss_block(section, &block)
  @section = @styleguide.section(section)
  modifiers = @section.modifiers

  @example_html = capture(&block)
  concat render(:partial => "styleguide_block", :locals => {
    :html => @example_html,
    :modifiers => modifiers})
end
{% endhighlight %}

## Other resources

* [Sinatra Example](https://github.com/kneath/kss/tree/master/example)
* [kss-rails](https://github.com/dewski/kss-rails) - A rails engine.

<script type="text/javascript">
  document.getElementById('nav-styleguide').className = 'selected'
</script>
