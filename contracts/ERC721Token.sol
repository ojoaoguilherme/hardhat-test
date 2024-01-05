// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";

contract ERC721Token is ERC721 {
  constructor() ERC721("ERC721 Token", "ERC721") {
    for (uint i = 0; i < 100; i++) {
      _mint(msg.sender, i + 1);
    }
  }
}
