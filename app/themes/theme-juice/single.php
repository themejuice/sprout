<?php include "partials/header.php"; ?>
<div class="content__wrapper">
  <div class="content">
    <?php if ( have_posts() ) { ?>
      <?php the_post(); ?>
      <h1><?php echo the_title(); ?></h1>
      <p><?php echo the_time("F j, Y"); ?></p>
      <?php the_content(); ?>
    <?php } else { ?>
      <h4>Sorry, the page could not be displayed.</h4>
    <?php } ?>
  </div>
  <!-- / content -->
  <?php include "partials/sidebar.php"; ?>
</div>
<?php include "partials/footer.php"; ?>