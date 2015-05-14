<?php /* Template Name: Page */; ?>
<?php include "partials/header.php"; ?>
<div class="content__wrapper">
  <div class="content">
    <?php if ( have_posts() ) { ?>
      <?php the_post(); ?>
      <?php if ( has_post_thumbnail() ) { ?>
        <img src="<?php echo tj_featured_image("blog-thumb"); ?>" alt="<?php echo tj_title(); ?>">
      <?php } ?>
      <h1><?php echo tj_title(); ?></h1>
      <?php the_content(); ?>
    <?php } else { ?>
      <h4>Sorry, the page could not be displayed.</h4>
    <?php } ?>
  </div>
  <!-- / content -->
  <?php include "partials/sidebar.php"; ?>
</div>
<?php include "partials/footer.php"; ?>