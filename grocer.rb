require 'pry'

def consolidate_cart(cart)
  cart_hash = {}
  cart.each do |item|
    item.each do |property, price|
      if cart_hash[property].nil?
        cart_hash[property] = price.merge({:count => 1})
      else
        cart_hash[property][:count] += 1
      end
    end
  end
  cart_hash
end

def apply_coupons(cart, coupons)
  # code here
  discounted = {}
  cart.each do |item, info|
    coupons.each do |coupon|
      if item == coupon[:item] && info[:count] >= coupon[:num]
        cart[item][:count] = cart[item][:count] - coupon[:num]
        if discounted[item + " W/COUPON"]
          discounted[item + " W/COUPON"][:count] += 1
        else
          discounted[item + " W/COUPON"] = {:price => coupon[:cost], :clearance => cart[item][:clearance], :count => 1}
        end
      end
    end
    discounted[item] = info

  end
  discounted
end

def apply_clearance(cart)
  # code here
  cart.each do |item, discount|
    if discount[:clearance] == true
      discount[:price] = (discount[:price] * 0.8).round(2)
    end
  end
  cart
end

def checkout(items, coupons)
  cart = consolidate_cart(items)
  cart1 = apply_coupons(cart, coupons)
  cart2 = apply_clearance(cart1)
  
  total = 0
  
  cart2.each do |name, price|
    total += price[:price] * price[:count]
  end
  
  total > 100 ? total * 0.9 : total
  
end

