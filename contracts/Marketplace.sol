// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;
import "@openzeppelin/contracts/token/ERC721/utils/ERC721Holder.sol";
import "@openzeppelin/contracts/token/ERC1155/utils/ERC1155Holder.sol";
import "@openzeppelin/contracts/interfaces/IERC1155.sol";
import "@openzeppelin/contracts/interfaces/IERC721.sol";

contract Marketplace is ERC1155Holder, ERC721Holder {
  function deposit(address nft, uint256 tokenId, uint256 amount) external {
    _handleNftTransfer(msg.sender, address(this), nft, tokenId, amount);
  }

  function _handleNftTransfer(
    address from,
    address to,
    address nft,
    uint256 tokenId,
    uint256 amount
  ) internal {
    bool erc1155 = IERC165(nft).supportsInterface(type(IERC1155).interfaceId);
    bool erc721 = IERC165(nft).supportsInterface(type(IERC721).interfaceId);

    require(erc1155 || erc721, "Neoki Marketplace: Unsupport token type");

    if (erc721) IERC721(nft).safeTransferFrom(from, to, tokenId, "0x");

    if (erc1155)
      IERC1155(nft).safeTransferFrom(from, to, tokenId, amount, "0x");
  }
}
