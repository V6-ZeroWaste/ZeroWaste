package kr.co.soaff.cart;

import lombok.Getter;
import lombok.Setter;

import java.util.List;

@Getter
@Setter
public class CartItemDTO {
    private List<Integer> item_no_array;
    private List<Integer> packing_status_array;
    private List<Integer> amount_array;
    private String status;
}