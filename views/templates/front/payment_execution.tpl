{*
 * WeArePlanet Prestashop
 *
 * This Prestashop module enables to process payments with WeArePlanet (https://www.weareplanet.com/).
 *
 * @author customweb GmbH (http://www.customweb.com/)
 * @copyright 2017 - 2023 customweb GmbH
 * @license http://www.apache.org/licenses/LICENSE-2.0 Apache Software License (ASL 2.0)
 *}
{capture name=path}
    <a href="{$link->getPageLink('order', true, NULL, "step=3")|escape:'html'}" title="{l s='Go back to the Checkout' mod='weareplanet'}">{l s='Checkout' mod='weareplanet'}</a><span class="navigation-pipe">{$navigationPipe}</span>{$name|escape:'html':'UTF-8'}
{/capture}

<h1 class="page-heading">
    {l s='Order Review' mod='weareplanet'}
</h1>

{assign var='current_step' value='payment'}
{include file="$tpl_dir./order-steps.tpl"}

{if $productNumber <= 0}
    <p class="alert alert-warning">
        {l s='Your shopping cart is empty.' mod='weareplanet'}
    </p>
{else}
	<div id="weareplanet-processing-spinner-container" class="weareplanet-processing-spinner-container invisible">
		<div class="weareplanet-processing-spinner"></div>
	</div>
	{if $showCart}
		<div class="box">
			<p>
                <strong class="dark">
				{l s='Please finalize the order by clicking "I confirm my order".' mod='weareplanet'}
			 </strong>
            </p>
		</div>
		{assign var='cartTemplate' value="{weareplanet_resolve_template template='cart_contents.tpl'}"}
		{include file="$cartTemplate"}
	{else}
		<div class="box">
			<p class="weareplanet-indent">
                <strong class="dark">
                	{l s='Please finalize your order.' mod='weareplanet'}
                </strong>
            </p>
			<p>
                - {l s='The total amount of your order comes to' mod='weareplanet'}
	                <span id="amount" class="price">{displayPrice price=$total_price}</span>
					{if $use_taxes == 1}
				    	{l s='(tax incl.)' mod='weareplanet'}
				    {/if}
            </p>
            <p>
                - {l s='To finalize the order click "I confirm my order".' mod='weareplanet'}
            </p>
		</div>
	{/if}
	
	<div id="weareplanet-error-messages"></div>
	
	
	<div id="weareplanet-payment-container">
	<h3 class="page-subheading" id="weareplanet-method-title">
        <span><span style="font-size:smaller">{l s='Payment Method:' mod='weareplanet'}</span> {$name|escape:'html':'UTF-8'}</span>
        
        <button class="button btn btn-default button-medium weareplanet-submit right invisible" id="weareplanet-submit-top" disabled >
            <span>{l s='I confirm my order' mod='weareplanet'}<i class="icon-chevron-right right"></i></span>
        </button>
    </h3>
	</div>
	<form action="{$form_target_url|escape:'html'}" method="post" id="weareplanet-payment-form">
    	<input type="hidden" name="cartHash" value="{$cartHash|escape:'html':'UTF-8'}" />
    	<input type="hidden" name="methodId" value="{$methodId|escape:'html':'UTF-8'}" />
    	
        <div id="weareplanet-method-configuration" class="weareplanet-method-configuration" style="display: none;"
	data-method-id="{$methodId|escape:'html':'UTF-8'}" data-configuration-id="{$configurationId|escape:'html':'UTF-8'}"></div>
		<div id="weareplanet-method-container">
			<input type="hidden" id="weareplanet-iframe-possible" name="weareplanet-iframe-possible" value="false" />
			<div class="weareplanet-loader"></div>		
		</div>
		
		{if $showTOS && $conditions && $cmsId}
	 		{if isset($overrideTOSDisplay) && $overrideTOSDisplay}
	        	{$overrideTOSDisplay|escape:'html':'UTF-8'}
			{else}
				<div class="box">
					<p class="checkbox">
						<input type="checkbox" name="cgv" id="cgv" value="1" {if $checkedTOS}checked="checked"{/if}/>
						<label for="cgv">{l s='I agree to the terms of service and will adhere to them unconditionally.' mod='weareplanet'}</label>
						<a href="{$linkConditions|escape:'html':'UTF-8'}" class="iframe" rel="nofollow">{l s='(Read the Terms of Service)' mod='weareplanet'}</a>
					</p>
				</div>
			{/if}
		{/if}
        <p class="cart_navigation clearfix" id="cart_navigation">
            <a class="button-exclusive btn btn-default" href="{$link->getPageLink('order', true, NULL, "step=3")|escape:'html':'UTF-8'}" tabindex="-1" id="weareplanet-back">
                <i class="icon-chevron-left"></i>{l s='Other payment methods' mod='weareplanet'}
            </a>
            <button class="button btn btn-default button-medium weareplanet-submit" id="weareplanet-submit-bottom" disabled>
                <span>{l s='I confirm my order' mod='weareplanet'}<i class="icon-chevron-right right"></i></span>
            </button>
        </p>
    </form>
    
    <script type="text/javascript">$("a.iframe").fancybox({
		"type" : "iframe",
		"width":600,
		"height":600
	});</script>
	
	{if $showTOS && $conditions && cmsId}
		{addJsDefL name=weareplanet_msg_tos_error}{l s='You must agree to the terms of service before continuing.'  mod='weareplanet' js=1}{/addJsDefL}
	{/if}
	{addJsDefL name=weareplanet_msg_json_error}{l s='The server experienced an unexpected error, you may try again or try to use a different payment method.'  mod='weareplanet' js=1}{/addJsDefL}
{/if}