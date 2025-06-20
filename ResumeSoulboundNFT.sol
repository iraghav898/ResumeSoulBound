// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/v4.9.0/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/v4.9.0/contracts/access/Ownable.sol";

contract ResumeSoulboundNFT is ERC721URIStorage, Ownable {
    uint256 public tokenCounter;

    constructor() ERC721("XGenesisResumeNFT", "XRESUME") {
        tokenCounter = 0;
    }

    // Mint NFT to a student (only by college/owner)
    function mintResumeNFT(address student, string memory tokenURI) public onlyOwner {
        uint256 newTokenId = tokenCounter;
        _safeMint(student, newTokenId);
        _setTokenURI(newTokenId, tokenURI);
        tokenCounter++;
    }

    //  Block transfers to make it Soulbound (non-transferable)
    function _beforeTokenTransfer(
        address from,
        address to,
        uint256 tokenId
    ) internal  {
      
        require(from == address(0), "This NFT is Soulbound and cannot be transferred");
        super._beforeTokenTransfer(from, to, tokenId, 0);
    }
}
