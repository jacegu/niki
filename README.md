Niki - A vanilla Ruby wiki
==========================

Update
------
This branch contains a second version of the wiki. This version was the result of another apprenticeship task. I was asked to:

- Make the wiki *functional*: **everything must be immutable**. No state change can happen. So, when a page is added or updated whate really takes place behind the curtains is that a new wiki is setted up and served.
- Refactor to **methods that are 2 lines long** at most.
- **Improve naming and readability**.


**Known issues**: There is an issue when the page title includes non ascii-8bit characters. We haven't managed to solve it yet but we will.

- - -

Purpose
-------
Niki is my first task as @ecomba's apprentice. I have to develop a wiki using only the Ruby Standard Library.

This is pretty close to [the challenge](http://github.com/jacegu/apprentice_challenge) I had to pass to [become apprentice](http://ecomba.org/blog/2011/05/15/the-apprentice/). The main difference is that I can use a test framework as long as it is part of the standard library.

The name
--------
The wiki is named after a beloved friend who has helped me a lot. Thanks Nikisoftware :·)

![Nikisoftware by @sbastn](http://kinisoftware.com/wp-content/uploads/2011/07/kini-02.png "Nikisoftware by @sebastn")

Features
--------
The set of features of the blog is small: this is supposed to be an MVP wiki.

- You can check the avaliable pages list
- You can add new pages
- You can see an existing page
- You can edit an existing page

Regarding the page content the set of features you have available is:

- **HMTL safe content:** if you write HTML in the wiki it won't be interpreted by the browser.
- **Paragraphs:** if you split your page content in paragraphs Niki will respect that structure.
- **Linking other niki pages**: You can create a link to other pages in the wiki by using the syntax `[the title of the page]`. Keep in mind that niki is case sansitive so a page entitled `page title` is different from another with the title `Page title`. Niki will also check if a page with given title exists. If no page with that title is found niki won't create a link.

A page example
-------------
Given **a page entitled _ipsum_ exists** but **NO page entitled _metus_ exists**, a niki page with the content

    Lorem [ipsum] dolor sit amet, consectetur adipiscing elit. Cras risus est, ultrices a tristique at, bibendum vel purus. Duis
    porttitor rutrum mauris, a accumsan leo auctor accumsan. Nulla aliquet fermentum nisl, vitae rutrum sapien imperdiet a.
    Curabitur arcu ante, semper at facilisis ac, laoreet a odio. Sed in elit turpis. Ut elit risus, porttitor at dignissim non,
    congue at est.

    Proin laoreet [metus] dignissim turpis varius sagittis vel condimentum sapien. Integer mattis vulputate ipsum laoreet lacinia.
    Nullam vehicula vestibulum convallis. Vivamus in dolor et massa dapibus suscipit. Duis rhoncus porttitor ornare. Praesent sem
    odio, porta vitae convallis eu, scelerisque a tortor. Duis interdum ipsum felis. Cras adipiscing mollis mi, vitae convallis
    justo vestibulum id.

will be rendered to

    <p>Lorem <a href-"/pages/ipsum">ipsum</a> dolor sit amet, consectetur adipiscing elit. Cras risus est, ultrices a tristique
    at, bibendum vel purus. Duis porttitor rutrum mauris, a accumsan leo auctor accumsan. Nulla aliquet fermentum nisl, vitae
    rutrum sapien imperdiet a. Curabitur arcu ante, semper at facilis s ac, laoreet a odio. Sed in elit turpis. Ut elit risus,
    porttitor at dignissim non, congue at est.</p>

    <p>Proin laoreet [metus] dignissim turpis varius sagittis vel condimentum sapien. Integer mattis vulputate ipsum laoreet
    lacinia.  Nullam vehicula vestibulum convallis. Vivamus in dolor et massa dapibus suscipit. Duis rhoncus porttitor ornare.
    Praesent sem odio, porta vitae convallis eu, scelerisque a tortor. Duis interdum ipsum felis. Cras adipiscing mollis mi,
    vitae convallis justo vestibulum id.</p>

Testing
-------
This time I was allowed to use a testing framework as long as it was part of the Ruby Standard Library. I choosed MiniTest to take advantage of its BDD syntax a la RSpec.

To be able to integration test the wiki I also used MiniTest. I extended the `MiniTest::Unit::TestCase` class with the `get` and `post` methods to be able to navigate the app. In order to DRY-up the starting and stoping of WEBRick in tests I created a `feature` helper. This helper creates a MiniTest especification with the starting and stopping of the server as its `before` and `after` blocks.
