<%inherit file='./_layout.mako'/>

<div class="header" align="center">
  <a href="/"><img width="64" height="64" src="${util.static_url('img/scrolliris-logo-64x64.png')}" alt="Scrolliris's Logo"></a>
  <h1 class="logo"><span class="scroll">Scroll</span><span class="iris">iris</span></h1>
  <ul class="nav">
    <li><a class="overview active link" href="/">${_('nav.header.overview')}</a></li>
    <li><a class="timeline link" href="${req.route_path('timeline')}">${_('nav.header.timeline')}</a></li>
    <li><a class="newsletter link" href="${var['tinyletter_url']}" target="_blank">${_('nav.header.newsletter')}</a></li>
    <li><a class="login link" href="https://scrolliris.com/login">${_('nav.header.login')}</a></li>
  </ul>
</div>

<div class="content" align="center">
  <div class="grid title" align="center">
    <div class="row">
      <div class="column-8 offset-4 column-l-14 offset-l-1 column-n-16">
        <h2 class="heading">${_('application.title')}</h2>
        <p class="description">${_('application.description')}</p>
        <div class="get-started">
          <p><a class="primary try button" href="https://try.scrolliris.com/">${_('get_started.title')}</a></p>
          or <a class="signup link" href="https://scrolliris.com/signup">Sign up</a>
          <p>${_('get_started.description')}</p>
        </div>
      </div>
    </div>
  </div>

  <div class="grid screenshot">
    <img class="console-screenshot" width="980" src="${util.static_url('img/screenshot.png')}" alt="screenshot">
  </div>

  <div class="grid feature">
    <div class="row">
      <div class="column-16" align="center">
        <h2 class="heading">${_('feature.title')}</h2>
      </div>
    </div>

    <div class="row">
      <div class="offset-2 column-4 offset-l-1 column-l-7 column-m-16" align="center">
        <section>
          <svg class="icon bar-chart" viewBox="0 0 8 8" width="48" height="48">
            <use xlink:href="#open-iconic.min_bar-chart" class="icon-bar-chart"></use>
          </svg>
          <h3 class="heading">${_('feature.analysis.title')}</h3>
          <p class="text">${_('feature.analysis.description')}</p>
        </section>
      </div>
      <div class="column-4 column-l-7 column-m-16" align="center">
        <section>
          <svg class="icon lock-locked" viewBox="0 0 8 8" width="48" height="48">
            <use xlink:href="#open-iconic.min_lock-locked" class="icon-lock-locked"></use>
          </svg>
          <h3 class="heading">${_('feature.privacy.title')}</h3>
          <p class="text">${_('feature.privacy.description')}</p>
        </section>
      </div>
      <div class="column-4 offset-l-4 column-l-8 column-m-16" align="center">
        <section>
          <svg class="icon wrench" viewBox="0 0 8 8" width="48" height="48">
            <use xlink:href="#open-iconic.min_wrench" class="icon-wrench"></use>
          </svg>
          <h3 class="heading">${_('feature.integration.title')}</h3>
          <p class="text">${_('feature.integration.description')}</p>
        </section>
      </div>
    </div>
  </div>

  <div class="grid customer">
    <div class="row">
      <div class="column-16" align=center>
        <div class="customer-container">
          <h3 class="heading">${_('customer.title')}</h3>
          <%include file='./_customer.mako'/>
        </div>
      </div>
    </div>
  </div>

  <div class="grid newsletter">
    <div class="row">
      <div class="column-16" align=center>
        <div class="newsletter-container">
          <h3 class="heading">${_('newsletter.title')}</h3>
          <div class="newsletter-form">
            <%include file='./_newsletter.mako'/>
          </div>
        </div>
      </div>
    </div>
  </div>

  <div class="grid link">
    <div class="row" align="center">
      <div class="link-container">
        <div class="offset-5 column-2 offset-v-2 column-v-4 column-m-16">
          <section>
            <a href="https://help.scrolliris.com/">
              <svg class="icon question-mark" viewBox="0 0 8 8" width="48" height="48">
                <use xlink:href="#open-iconic.min_question-mark" class="icon-question-mark"></use>
              </svg>
              <span class="help">${_('nav.link.help')}</span>
            </a>
          </section>
        </div>
        <div class="column-2 column-v-4 column-m-16">
          <section>
            <a href="https://log.scrolliris.com/">
              <svg class="icon pulse" viewBox="0 0 8 8" width="48" height="48">
                <use xlink:href="#open-iconic.min_pulse" class="icon-pulse"></use>
              </svg>
              <span class="changelog">${_('nav.link.log')}</span>
            </a>
          </section>
        </div>
        <div class="column-2 column-v-4 column-m-16">
          <section>
            <a href="https://doc.scrolliris.com/how_it_works/overview.html">
              <svg class="icon document" viewBox="0 0 8 8" width="48" height="48">
                <use xlink:href="#open-iconic.min_document" class="icon-document"></use>
              </svg>
              <span class="documentation">${_('nav.link.doc')}</span>
            </a>
          </section>
        </div>
      </div>
    </div>

    <hr class="line">

    <a class="secondary signup button" href="https://scrolliris.com/signup">Sign up</a>
    <h6>${_('link.question.title')}</h6>
    <p>${_('link.question.mail', mapping={'mail': 'support@scrolliris.com'})|n,trim,clean(tags=['a', 'code'], attributes={'a': ['href'], 'code':[]})}</p>
  </div>

  <div class="grid about">
    <div class="row">
      <div class="column-16" align=center>
        <h5><a class="logo" href="https://lupine-software.com/"><img class="logo-img" src="${util.static_url('img/lupine-software-logo-64x64.png')}" width="64px" height="64px" alt="Lupine Software's Logo"></a></h5>
        <p>${_('about.text', mapping={'href': 'https://lupine-software.com/'})|n,trim,clean(tags=['a', 'svg', 'use'], attributes={'a': ['class', 'href'], 'svg': util.allow_svg('0 0 8 8'), 'use': ['href', 'class']})}</p>
      </div>
    </div>
  </div>
</div>
