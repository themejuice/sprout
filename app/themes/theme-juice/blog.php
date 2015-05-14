<?php /* Template Name: Blog */; ?>
<?php include "partials/header.php"; ?>
<div class="content__wrapper">
  <div class="content">
    <h1><?php echo tj_title(); ?></h1>
    <?php $paged = tj_query_var(); ?>
    <?php $posts = new WP_Query( array( "post_type" => "post", "showposts" => 5, "paged" => $paged ) ); ?>
    <?php if ( $posts->have_posts() ) { ?>
      <?php while ( $posts->have_posts() ) { ?>
        <?php $posts->the_post(); ?>
        <div class="blog-page__post">
          <?php if ( has_post_thumbnail() ) { ?>
            <div class="blog-page__post__thumb">
              <div class="blog-page__post__thumb__overflow">
                <img src="<?php echo tj_featured_image("blog-thumb"); ?>" alt="<?php echo tj_title(); ?>">
              </div>
            </div>
          <?php } ?>
          <div class="blog-page__post__content">
            <a href="<?php echo the_permalink(); ?>">
              <h2><?php echo tj_title(); ?></h2>
            </a>
            <p><?php echo the_time("F j, Y"); ?></p>
            <p><?php echo tj_excerpt(); ?></p>
            <a class="button" href="<?php echo the_permalink(); ?>">
              Read More
            </a>
          </div>
          <hr>
        </div>
        <!-- / post -->
      <?php } ?>
      <div class="pagination">
        <?php echo paginate_links( array( "current" => max(1, $paged), "total" => $posts->max_num_pages ) ); ?>
      </div>
    <?php } else { ?>
      <h4>Sorry, there are currently no posts for <?php echo tj_title(); ?>.</h4>
    <?php } ?>
    <?php wp_reset_query(); ?>
  </div>
  <!-- / content -->
  <?php include "partials/sidebar.php"; ?>
</div>
<?php include "partials/footer.php"; ?>