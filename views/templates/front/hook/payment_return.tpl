{*
 * WeArePlanet Prestashop
 *
 * This Prestashop module enables to process payments with WeArePlanet (https://www.weareplanet.com/).
 *
 * @author customweb GmbH (http://www.customweb.com/)
 * @copyright 2017 - 2023 customweb GmbH
 * @license http://www.apache.org/licenses/LICENSE-2.0 Apache Software License (ASL 2.0)
 *}
<h3>{l s='Your order on %s is complete.' sprintf=$shop_name mod='weareplanet'}</h3>
<div class="weareplanet_return">
	<br />{l s='Amount' mod='weareplanet'}: <span class="price"><strong>{$total|escape:'htmlall':'UTF-8'}</strong></span>
	<br />{l s='Order Reference' mod='weareplanet'}: <span class="reference"><strong>{$reference|escape:'html':'UTF-8'}</strong></span>
	<br /><br />{l s='An email has been sent with this information.' mod='weareplanet'}
	<br /><br />{l s='If you have questions, comments or concerns, please contact our' mod='weareplanet'} <a href="{$link->getPageLink('contact', true)|escape:'html':'UTF-8'}">{l s='expert customer support team.' mod='weareplanet'}</a>
</div>
