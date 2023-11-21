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

class WeArePlanetOrderModuleFrontController extends WeArePlanetFrontpaymentcontroller
{
    public $ssl = true;

    public function postProcess()
    {
        $methodId = Tools::getValue('methodId', null);
        $cartHash = Tools::getValue('cartHash', null);
        if ($methodId == null || $cartHash == null) {
            $this->context->cookie->pln_error = $this->module->l(
                'There was a technical issue, please try again.',
                'order'
            );
            echo json_encode(
                array(
                    'result' => 'failure',
                    'redirect' => $this->context->link->getPageLink('order', true, null, "step=3")
                )
            );
            die();
        }
        $cart = $this->context->cart;
        $redirect = $this->checkAvailablility($cart);
        if (! empty($redirect)) {
            echo json_encode(array(
                'result' => 'failure',
                'redirect' => $redirect
            ));
            die();
        }

        $spaceId = Configuration::get(WeArePlanetBasemodule::CK_SPACE_ID, null, null, $cart->id_shop);
        $methodConfiguration = new WeArePlanetModelMethodconfiguration($methodId);
        if (! $methodConfiguration->isActive() || $methodConfiguration->getSpaceId() != $spaceId) {
            $this->context->cookie->pln_error = $this->module->l(
                'This payment method is no longer available, please try another one.',
                'order'
            );
            echo json_encode(
                array(
                    'result' => 'failure',
                    'redirect' => $this->context->link->getPageLink('order', true, null, "step=3")
                )
            );
            die();
        }

        $cmsId = Configuration::get('PS_CONDITIONS_CMS_ID', null, null, $cart->id_shop);
        $conditions = Configuration::get('PS_CONDITIONS', null, null, $cart->id_shop);
        $showTos = Configuration::get(WeArePlanet::CK_SHOW_TOS, null, null, $cart->id_shop);

        if ($cmsId && $conditions && $showTos) {
            $agreed = Tools::getValue('cgv');

            if (! $agreed) {
                $this->context->cookie->checkedTOS = null;
                $this->context->cookie->pln_error = $this->module->l('Please accept the terms of service.', 'order');
                echo json_encode(array(
                    'result' => 'failure',
                    'reload' => 'true'
                ));
                die();
            }
            $this->context->cookie->checkedTOS = 1;
        }

        WeArePlanetFeehelper::removeFeeSurchargeProductsFromCart($cart);
        WeArePlanetFeehelper::addSurchargeProductToCart($cart);
        WeArePlanetFeehelper::addFeeProductToCart($methodConfiguration, $cart);

        if ($cartHash != WeArePlanetHelper::calculateCartHash($cart)) {
            $this->context->cookie->pln_error = $this->module->l('The cart was changed, please try again.', 'order');
            echo json_encode(array(
                'result' => 'failure',
                'reload' => 'true'
            ));
            die();
        }

        $orderState = WeArePlanetOrderstatus::getRedirectOrderStatus();
        try {
            $customer = new Customer((int) $cart->id_customer);
            $this->module->validateOrder(
                $cart->id,
                $orderState->id,
                $cart->getOrderTotal(true, Cart::BOTH, null, null, false),
                'weareplanet_' . $methodId,
                null,
                array(),
                null,
                false,
                $customer->secure_key
            );
            $noIframeParamater = Tools::getValue('weareplanet-iframe-possible', null);
            $noIframe = $noIframeParamater == 'false';
            if ($noIframe) {
                $url = WeArePlanetServiceTransaction::instance()->getPaymentPageUrl(
                    $GLOBALS['weareplanetTransactionIds']['spaceId'],
                    $GLOBALS['weareplanetTransactionIds']['transactionId']
                );
                echo json_encode(array(
                    'result' => 'redirect',
                    'redirect' => $url
                ));
                die();
            }
            echo json_encode(array(
                'result' => 'success'
            ));
            die();
        } catch (Exception $e) {
            $this->context->cookie->pln_error = WeArePlanetHelper::cleanExceptionMessage($e->getMessage());
            echo json_encode(
                array(
                    'result' => 'failure',
                    'redirect' => $this->context->link->getPageLink('order', true, null, "step=3")
                )
            );
            die();
        }
    }

    public function setMedia()
    {
        // We do not need styling here
    }

    protected function displayMaintenancePage()
    {
        // We want never to see here the maintenance page.
    }

    protected function displayRestrictedCountryPage()
    {
        // We do not want to restrict the content by any country.
    }

    protected function canonicalRedirection($canonical_url = '')
    {
        // We do not need any canonical redirect
    }
}
