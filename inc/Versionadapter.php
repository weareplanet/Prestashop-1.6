<?php
/**
 * WeArePlanet Prestashop
 *
 * This Prestashop module enables to process payments with WeArePlanet (https://www.weareplanet.com/).
 *
 * @author customweb GmbH (http://www.customweb.com/)
 * @copyright 2017 - 2023 customweb GmbH
 * @license http://www.apache.org/licenses/LICENSE-2.0 Apache Software License (ASL 2.0)
 */

class WeArePlanetVersionadapter
{
    public static function getConfigurationInterface()
    {
        return Adapter_ServiceLocator::get('Core_Business_ConfigurationInterface');
    }

    public static function getAddressFactory()
    {
        return Adapter_ServiceLocator::get('Adapter_AddressFactory');
    }

    public static function clearCartRuleStaticCache()
    {
    }

    public static function getAdminOrderTemplate()
    {
        return 'views/templates/admin/hook/admin_order.tpl';
    }

    /**
     * Returns true if the refund is only voucher, not required to be sent to WeArePlanet.
     *
     * @param [] $postData
     * @return boolean
     */
    public static function isVoucherOnlyWeArePlanet($postData)
    {
        return isset($postData['generateDiscountRefund']) && ! isset($postData['weareplanet_offline']);
    }
}
