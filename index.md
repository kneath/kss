---
layout: default
---

<div class="intro">

  <div class="inner">

    <div class="description">
      <h1 class="kss-text">KSS Knyle Style Sheets</h1>
      <p>
        Documentation for any flavor of CSS that you’ll love to write. Human readable, machine parsable, and easy to remember.
      </p>
      <p class="subdued">
        Works great with CSS, SCSS, LESS, PHP, Ruby,  Python,  Java, or plain old static files.
      </p>
    </div>

    <div class="example">

{% highlight scss %}
// A button suitable for giving stars to someone.
//
// :hover             - Subtle hover highlight.
// .stars-given       - A highlight indicating you've already given a star.
// .stars-given:hover - Subtle hover highlight on top of stars-given styling.
// .disabled          - Dims the button to indicate it cannot be used.
//
// Styleguide 2.1.3.
a.button.star{
  ...
  &.star-given{
    ...
  }
  &.disabled{
    ...
  }
}
{% endhighlight %}

    </div>

  </div>

  <hr />
  <span class="hr-seal"></span>
</div>