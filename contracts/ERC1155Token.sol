// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;
import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";

contract ERC1155Token is ERC1155 {
  constructor() ERC1155("uri") {
    for (uint i = 0; i < 100; i++) {
      _mint(msg.sender, i + 1, 4, "0x");
    }
  }
}
