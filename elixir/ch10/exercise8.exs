defmodule Exercise8 do
  ## ListsAndRecursion-8
  @tax_rates [ NC: 0.075, TX: 0.08]
  @orders [
    [ id: 123, ship_to: :NC, net_amount: 100.00],
    [ id: 124, ship_to: :OK, net_amount: 35.50],
    [ id: 125, ship_to: :TX, net_amount: 24.00],
    [ id: 126, ship_to: :TX, net_amount: 44.80],
    [ id: 127, ship_to: :NC, net_amount: 25.00],
    [ id: 128, ship_to: :MA, net_amount: 10.00],
    [ id: 129, ship_to: :CA, net_amount: 102.00],
    [ id: 130, ship_to: :NC, net_amount: 50.00]
  ]

  def e8(), do: e8do(@orders, @tax_rates)

  def e8do(orders, taxes) do
    orders
      |> Enum.map(fn (order) -> 
        put_in(order, [:total_amount], calc_total(order, taxes))
      end)
  end

  def calc_total(order, taxes) do
    order[:net_amount] * calc_tax_rate(order, taxes)
  end

  def calc_tax_rate(order, taxes) do
    1 + (taxes[order[:ship_to]] || 0) 
  end
end

