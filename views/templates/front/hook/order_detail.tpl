{*
 * WeArePlanet Prestashop
 *
 * This Prestashop module enables to process payments with WeArePlanet (https://www.weareplanet.com/).
 *
 * @author customweb GmbH (http://www.customweb.com/)
 * @copyright 2017 - 2023 customweb GmbH
 * @license http://www.apache.org/licenses/LICENSE-2.0 Apache Software License (ASL 2.0)
 *}
<div id="weareplanet_documents" style="display:none">
{if !empty($weArePlanetInvoice)}
	<p class="weareplanet-document">
		<i class="icon-file-text-o"></i>
		<a target="_blank" href="{$weArePlanetInvoice|escape:'html'}">{l s='Download your %s invoice as a PDF file.' sprintf='WeArePlanet' mod='weareplanet'}</a>
	</p>
{/if}
{if !empty($weArePlanetPackingSlip)}
	<p class="weareplanet-document">
		<i class="icon-truck"></i>
		<a target="_blank" href="{$weArePlanetPackingSlip|escape:'html'}">{l s='Download your %s packing slip as a PDF file.' sprintf='WeArePlanet' mod='weareplanet'}</a>
	</p>
{/if}
</div>
<script type="text/javascript">

jQuery(function($) {    
    $('#weareplanet_documents').find('p.weareplanet-document').each(function(key, element){
	
		$(".info-order.box").append(element);
    });
});

</script>