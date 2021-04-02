<?php
/**
 * A Route Prestashop Extension that adds secure shipping
 * protection to your orders
 *
 * Php version 7.0^
 *
 * @author    Route Development Team <dev@routeapp.io>
 * @copyright 2019 Route App Inc. Copyright (c) https://www.routeapp.io/
 * @license   https://www.routeapp.io/merchant-terms-of-use  Proprietary License
 */

require_once 'RouteApi.php';

class RouteShipment
{
    public function __construct($token = '', $env = '', $handler = null)
    {
        if (isset($handler)) {
            $this->handler = $handler;
        } else {
            $this->handler = new RouteApi($token, $env);
        }
    }

    /**
     * Return a single shipment by ID
     *
     * @param string $id The tracking number
     *
     * @return mixed|json
     */
    public function getShipment($id)
    {
        return $this->handler->get('/shipments/' . $id)['body'];
    }

    /**
     * Create a shipment
     *
     * @param mixed $params The shipment params
     *
     * @return self object
     */
    public function createShipment($params)
    {
        return $this->handler->post('/shipments', $params);
    }

    /**
     * Update a shipment
     *
     * @param string $id The tracking number
     * @param mixed $params The shipment params
     *
     * @return self object
     */
    public function updateShipment($id, $params)
    {
        return $this->handler->post('/shipments/' . $id, $params);
    }

    /**
     * Cancel a shipment (by order ID, cancel all existents shipments)
     *
     * @param object $orderId
     * @param string $trackingNumber
     *
     * @return void
     */
    public function cancelShipment($orderId, $trackingNumber = '')
    {
        $webOrder = $this->handler->get('/web/orders/' . $orderId)['body'];
        if (empty($webOrder)) {
            return;
        }

        foreach ($webOrder['shipments'] as $shipment) {
            if (!empty($trackingNumber) && Tools::strtoupper($trackingNumber) != $shipment['trackingNumber']) {
                $this->handler->post('/shipments/' . $shipment['trackingNumber'] . '/cancel');
            }
        }
    }

    /**
     * Upsert a shipment. If the shipment exists, will update it, if not, will create.
     *
     * @param string $id The tracking number
     * @param mixed $params The shipment params
     *
     * @return self object
     */
    public function upsertShipment($id, $params)
    {
        return $this->getShipment($id) ? $this->updateShipment($id, $params) : $this->createShipment($params);
    }
}
