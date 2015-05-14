<?php $theme->render_head(); ?>
<div class="header__wrapper">
  <div class="header">
    <div class="header__logo">
      <a href="<?php echo home_url(); ?>">
        <img src="<?php echo tj_image_src("logo.png"); ?>" alt="Theme Juice">
      </a>
    </div>
    <!-- / logo -->
    <div class="header__navigation">
      <i class="hamburger fa fa-bars"></i>
      <?php wp_nav_menu( array( "theme_location" => "primary_nav" ) ); ?>
    </div>
    <!-- / nav -->
  </div>
</div>
<!-- / header -->