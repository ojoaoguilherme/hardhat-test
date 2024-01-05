import { loadFixture } from "@nomicfoundation/hardhat-network-helpers";
import { expect } from "chai";
import { ethers } from "hardhat";
import { describe, it } from "mocha";
import { parseEther } from "ethers";
import { ERC1155, ERC721, Marketplace } from "../typechain-types";

describe.only("NFT Marketplace Testing", function () {
  async function createMarketplace() {
    const erc1155 = (await ethers.deployContract(
      "ERC1155Token"
    )) as unknown as ERC1155;
    const erc721 = (await ethers.deployContract(
      "ERC721Token"
    )) as unknown as ERC721;
    const cut = (await ethers.deployContract(
      "Marketplace"
    )) as unknown as Marketplace;
    await erc1155.waitForDeployment();
    await erc721.waitForDeployment();
    await cut.waitForDeployment();

    await Promise.all([
      erc1155.setApprovalForAll(cut.target, true),
      erc721.setApprovalForAll(cut.target, true),
    ]);
    return { cut, erc1155, erc721 };
  }

  describe("Testing listing NFT to marketplace", function () {
    it("marketplace should be able to receive ERC721 NFTs", async function () {
      // INFO: working test
      const { cut, erc721 } = await loadFixture(createMarketplace);
      const [owner] = await ethers.getSigners();
      await expect(cut.deposit(erc721.target, 1, 1)).to.changeTokenBalances(
        erc721,
        [owner, cut],
        [-1, 1]
      );
    });

    it("marketplace should be able to receive ERC1155 NFTs", async function () {
      // INFO: NOT working test
      const { cut, erc1155 } = await loadFixture(createMarketplace);
      const [owner] = await ethers.getSigners();
      await expect(cut.deposit(erc1155.target, 1, 1)).to.changeTokenBalances(
        erc1155,
        [owner, cut],
        [-2, 2]
      );
    });
  });
});
