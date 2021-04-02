{*
* A Route Prestashop Extension that adds secure shipping
* protection to your orders
*
* Php version 7.0^
*
* @author    Route Development Team <dev@routeapp.io>
* @copyright 2019 Route App Inc. Copyright (c) https://www.routeapp.io/
* @license   https://www.routeapp.io/merchant-terms-of-use  Proprietary License
*}

<script src="{$widget|escape:'javascript':'UTF-8'}"></script>
<div id="RouteWidget" class="route-div" data-default-checked="{$selected|escape:'javascript':'UTF-8'}"></div>
<!--{literal}-->
<script language="JavaScript" type="text/JavaScript">
    var subtotal = "{/literal}{$subtotal|escape:'javascript':'UTF-8'}{literal}";
    var token = "{/literal}{$token|escape:'javascript':'UTF-8'}{literal}";
    var routeController = "{/literal}{$routeController|cleanHtml nofilter}{literal}";
    var currency = "{/literal}{$currency|escape:'javascript':'UTF-8'}{literal}";
    var env = "{/literal}{$environment|escape:'javascript':'UTF-8'}{literal}";
    var routeTax = "{/literal}{$routeTax|escape:'javascript':'UTF-8'}{literal}";
    var routeFee = false;

    var updateInsurance = function (data) {
        routeFee = data;
        var insurance_price = data.insurance_selected ? data.insurance_price : 0.0;
        var old_price = 0.0;
        var display_fee = '';
        $.ajax({
            type: "GET",
            url: routeController,
            async: false,
            cache: false,
            data: {
              "is_route_insured": data.insurance_selected,
              "insurance_price": insurance_price,
              "currency": currency
            },
            success: function(res){
                var data = JSON.parse(res);
                old_price = data.last_price;
                display_fee = `${data.formatted_price}`;
            },
            error: function() {
                alert("ERROR:");
            }
        });

        if (data.insurance_selected && data.insurance_price) {
            var fee = data.insurance_price;

            var callAdjustSummary = true;
            var subtotalLine = document.getElementById("route-subtotal-line");
            if (subtotalLine) {
                subtotalLine.remove();
                callAdjustSummary = false;
            }

            const html = '<div id="route-subtotal-line" class="cart-summary-line cart-summary-subtotals"><span class="label">Route Shipping Protection</span><span class="value">' + display_fee + '</span></div>';
            document.getElementById("cart-subtotal-shipping").insertAdjacentHTML("afterend", html);

            if (callAdjustSummary) {
                adjustSummaryLines(fee, 'inc');
            }

            adjustPaymentInfo(fee, 'inc');

            var table = getSummaryTable();
            if(table) {
                var row = table.insertRow(2);
                row.setAttribute("id", "route-subtotal-row");
                var cell1 = row.insertCell(0);
                var cell2 = row.insertCell(1);
                cell1.innerHTML = "Route Shipping Protection";

                cell2.innerHTML = display_fee;
                adjustSummaryRows(fee, 'inc');
            }
        }

        if (data.insurance_selected === false) {
            var oldRouteFee = old_price;
            if (parseFloat(old_price) == 0) {
                try{
                    oldRouteFee = parseAmount(document.getElementById("route-subtotal-line").getElementsByClassName('value')[0].innerText);
                }catch (e){

                }
            }

            var subtotalLine = document.getElementById("route-subtotal-line");
            var subtotalRow =  document.getElementById("route-subtotal-row");

            if (subtotalLine) {
            subtotalLine.remove();
            }

            if (subtotalRow) {
            subtotalRow.remove();
            }

            adjustSummaryLines(oldRouteFee, 'dec');
            adjustSummaryRows(oldRouteFee, 'dec');
            adjustPaymentInfo(oldRouteFee, 'dec');
        }
    };

    var parseAmount = function (str) {
        if (!str) return 0;
        //The second .replace() handles the case where there are words at the end that might include a comma or period
        // which specifically happens when selecting the Pay by check option.
        var stripped = str.replace(/[^\d.,-]/g, '').replace(/[.,]$/, '');
        return Tools.parseFloatFromString(stripped, false);
    };

    var findTargetLines = function (element, target) {
        var lines = [];
        if (
            HTMLCollection.prototype.isPrototypeOf(element.children)
            && element.children.length == 2
            && element.children[0].innerHTML.toLowerCase().includes(target)
            && !element.children[0].innerHTML.toLowerCase().includes('subtotal')
        ) {
            if (element.children[0].innerHTML.toLocaleLowerCase().includes('incl')) {
                return [{tax_included: true, element: element.getElementsByClassName("value")[0]}]
            }
            return [{tax_included: false, element: element.getElementsByClassName("value")[0]}];
        }
        else if (HTMLCollection.prototype.isPrototypeOf(element)) {
            for (child of element) {
                var line = findTargetLines(child, target);
                lines = lines.concat(line)
            }
        }
        return lines;
    }

    var adjustSummaryLines = function (fee, type) {
        if (parseFloat(fee) !== 0.0) {
            var summaryLines = document.getElementById("js-checkout-summary").getElementsByClassName("cart-summary-totals")[0].getElementsByClassName("cart-summary-line");
            var totalLines = findTargetLines(summaryLines, 'total');
            var taxLines = findTargetLines(summaryLines, 'taxes');

            adjustLines(totalLines, parseFloat(fee), parseFloat(routeTax), type);
            adjustLines(taxLines, parseFloat(routeTax), 0.0, type);
        }
    }

    var adjustLines = function (lines, amount, tax, type) {
        var lineAmounts = [];
        for (line of lines) {
            var toAdjust = line.tax_included ? amount + tax : amount;
            if (type === 'inc') {
                lineAmounts.push(parseAmount(line.element.innerHTML) + toAdjust);
            }
            else if (type === 'dec') {
                lineAmounts.push(parseAmount(line.element.innerHTML) - toAdjust);
            }
        }

        formatPrices(lineAmounts).then((res) => {
            for (index = 0; index < res.length; index++) {
                lines[index].element.innerHTML = res[index];
            }
        });
    }

    var getTotalRows = function(table) {
        var totalRows = [];
        for (row of table.rows) {
            if (row.innerHTML.toLowerCase().includes('total') && !row.innerHTML.toLowerCase().includes('subtotal')) {
                totalRows.push(row.cells[1]);
            }
        }
        return totalRows;
    }

    var adjustSummaryRows = function (fee, type) {
        var table = getSummaryTable();
        if (table && table.rows) {
            var totalRows = getTotalRows(table);

            var newPrices = [];
            if (type === 'inc') {
                for (row of totalRows) {
                    newPrices.push(parseAmount(row.innerText) + fee);
                }
            } else if (type === 'dec') {
                for (row of totalRows) {
                    newPrices.push(parseAmount(row.innerText) - fee);
                }
            }
            formatPrices(newPrices).then((res) => {
                for (index = 0; index < res.length; index++) {
                    totalRows[index].innerText = res[index];
                }
            });
        }
    }

    var formatPrices = async function(prices) {
        var result = await $.ajax({
            type: "GET",
            url: routeController,
            data: {
                pricesToFormat: prices
            },
            success: function(res){
            },
            error: function() {
                alert("ERROR:");
            }
        });
        return JSON.parse(result);
    }

    var getSummaryTable = function () {
        try{
            return document.getElementById('order-items').getElementsByClassName("order-confirmation-table")[0].getElementsByTagName("table")[0];
        }catch (e) {
            return;
        }
    }

    var adjustPaymentInfo = function(fee, type) {
        if (fee !== 0.0) {
            var options = document.getElementsByClassName('payment-options').length > 0 ? document.getElementsByClassName('payment-options')[0].getElementsByClassName('additional-information') : [];
            var paymentDescriptions = findPaymentDesciptions(options);
            var descriptionAmounts = [];
            for (descAmount of paymentDescriptions) {
                if (descAmount) {
                    if (type === 'inc') {
                        descriptionAmounts.push(parseAmount(descAmount.innerHTML) + fee + parseFloat(routeTax));
                    } else if (type === 'dec') {
                        descriptionAmounts.push(parseAmount(descAmount.innerHTML) - fee - parseFloat(routeTax));
                    }
                }
            }

            formatPrices(descriptionAmounts).then((res) => {
                for (index = 0; index < res.length; index++) {
                    paymentDescriptions[index].innerHTML = res[index];
                }
            });
        }
    }

    var findPaymentDesciptions = function (elements) {
        var descriptions = [];
        for (child of elements) {
            var descriptionElements = child.getElementsByTagName('dd');
            descriptions.push(descriptionElements[0]);
        }
        return descriptions;
    }

    routeapp.get_quote(token, subtotal, currency, updateInsurance, env);
    routeapp.on_insured_change(updateInsurance);

    window.addEventListener('load', function() {
        jQuery(document).ready(function () {
            if(typeof prestashop !== 'undefined') {
                prestashop.on(
                    'changedCheckoutStep',
                    function (event) {
                        if (event.event.target.name !== undefined) {
                            if (event.event.target.name.match(/^delivery_option\[\d\]$/)) {
                                setTimeout(function(){
                                    if (routeFee) {
                                        updateInsurance(routeFee);
                                    }
                                }, 500);
                            }
                        }
                    }
                );
            }
        });
    });
</script>
<!--{/literal}-->
