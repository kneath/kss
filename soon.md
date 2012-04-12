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

<div class="inner three-col">
  <div class="column left">
    <h2>Documentation for humans</h2>
    <p>
      Documentation is all about communication. Between people, not computers. So why should your documentation format cater to computers?
    </p>
    <p>
      KSS’s documentation syntax is human readable, but just structured enough to be machine parsable.
    </p>
    <p>
      And it takes less than 5 minutes to <a href="/kss/syntax">learn the syntax</a>.
    </p>
  </div>

  <div class="column middle">
    <h2>Works with SCSS, LESS, and more</h2>
    <p>
      KSS is designed to work with every flavor of CSS out there — preprocessor or not. Choose whatever works for you.
    </p>
    <p>
      And it doesn’t matter if your website is running Java, PHP or assembly — KSS doesn’t care. Generate styleguides as static files and you’re good to go with (almost) any webserver on the planet.
    </p>
  </div>

  <div class="column right">
    <h2>Automatically generate styleguides</h2>
    <p>
      Create example HTML for your CSS and automatically generate variations of each element.
    </p>

    <p>
      Ever wanted to see the hover, active, and visited states for a link all at once? No problem.
    </p>

    <p>
      Learn how to <a href="/kss/styleguides">generate a living styleguide</a> for your project.
    </p>
  </div>
</div>

<script type="text/javascript">
  document.getElementById('nav-introduction').className = 'selected'
</script>