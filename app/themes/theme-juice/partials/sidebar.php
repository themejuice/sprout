<div class="sidebar">
  <div class="sidebar__section">
    <h2>Categories</h2>
    <ul class="categories">
      <?php echo wp_list_categories( array( "title_li" => false, "orderby" => "count", "orderby" => "title", "order" => "asc" ) ); ?>
    </ul>
  </div>
  <!-- / categories -->
</div>
<!-- / sidebar -->