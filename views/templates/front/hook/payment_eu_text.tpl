{*
 * WeArePlanet Prestashop
 *
 * This Prestashop module enables to process payments with WeArePlanet (https://www.weareplanet.com/).
 *
 * @author customweb GmbH (http://www.customweb.com/)
 * @copyright 2017 - 2023 customweb GmbH
 * @license http://www.apache.org/licenses/LICENSE-2.0 Apache Software License (ASL 2.0)
 *}
{$name|escape:'html':'UTF-8'}
{if !empty($description)}
			<span class="payment-method-description">{weareplanet_clean_html text=$description}</span>
{/if}

{if !empty($surchargeValues)}
	<span class="weareplanet-surcharge weareplanet-additional-amount"><span class="weareplanet-surcharge-text weareplanet-additional-amount-text">{l s='Minimum Sales Surcharge:' mod='weareplanet'}</span>
		<span class="weareplanet-surcharge-value weareplanet-additional-amount-value">
			{if $priceDisplay}
	          	{displayPrice price=$surchargeValues.surcharge_total} {if $display_tax_label}{l s='(tax excl.)' mod='weareplanet'}{/if}
	        {else}
	          	{displayPrice price=$surchargeValues.surcharge_total_wt} {if $display_tax_label}{l s='(tax incl.)' mod='weareplanet'}{/if}
	        {/if}
       </span>
   </span>
{/if}
{if !empty($feeValues)}
	<span class="weareplanet-payment-fee weareplanet-additional-amount"><span class="weareplanet-payment-fee-text weareplanet-additional-amount-text">{l s='Payment Fee:' mod='weareplanet'}</span>
		<span class="weareplanet-payment-fee-value weareplanet-additional-amount-value">
			{if $priceDisplay}
	          	{displayPrice price=$feeValues.fee_total} {if $display_tax_label}{l s='(tax excl.)' mod='weareplanet'}{/if}
	        {else}
	          	{displayPrice price=$feeValues.fee_total_wt} {if $display_tax_label}{l s='(tax incl.)' mod='weareplanet'}{/if}
	        {/if}
       </span>
   </span>
{/if}