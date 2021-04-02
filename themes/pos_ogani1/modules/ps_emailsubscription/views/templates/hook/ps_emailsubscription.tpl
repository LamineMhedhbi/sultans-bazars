<div class="ft_newsletter">
	<div class="container">
		<div class="content_newsletter">
			<form action="{$urls.pages.index}#footer" method="post">
				<div class="input-wrapper">
				  <input
					name="email"
					class="input_txt"
					type="text"
					value="{$value}"
					placeholder="{l s='Your email address' d='Shop.Forms.Labels'}"
				  >
				</div>
				<button class="btn btn-primary" name="submitNewsletter" type="submit" value="{l s='Submit' d='Shop.Theme.Actions'}"><i class="icon-envelope-open icons"></i></button>
				<input type="hidden" name="action" value="0">
			</form>
			<h3 class="footer_header">
				{l s='Spectators are our passion. Creation is our core.'  d='Shop.Theme'}
			</h3>
		</div>
	</div>
</div>