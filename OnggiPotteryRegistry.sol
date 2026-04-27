// SPDX-License-Identifier: MIT
pragma solidity 0.8.31;

contract OnggiPotteryRegistry {

    struct OnggiTradition {
        string vesselName;          // onggi, jangdok, hangari, dok, etc.
        string region;              // Ulsan, Jeolla, Gyeongsang
        string materials;           // porous clay, natural ash glazes
        string techniques;          // hand-coiling, paddle-and-anvil, wheel-throwing
        string functionalProperties;// breathability, fermentation control
        string culturalContext;     // kimchi, doenjang, gochujang, rituals
        string uniqueness;          // regional identity, UNESCO status
        address creator;
        uint256 likes;
        uint256 dislikes;
        uint256 createdAt;
    }

    struct OnggiInput {
        string vesselName;
        string region;
        string materials;
        string techniques;
        string functionalProperties;
        string culturalContext;
        string uniqueness;
    }

    OnggiTradition[] public traditions;
    mapping(uint256 => mapping(address => bool)) public hasVoted;

    event OnggiRecorded(uint256 indexed id, string vesselName, address indexed creator);
    event OnggiVoted(uint256 indexed id, bool like, uint256 likes, uint256 dislikes);

    constructor() {
        traditions.push(
            OnggiTradition({
                vesselName: "Example (replace manually)",
                region: "example",
                materials: "example",
                techniques: "example",
                functionalProperties: "example",
                culturalContext: "example",
                uniqueness: "example",
                creator: address(0),
                likes: 0,
                dislikes: 0,
                createdAt: block.timestamp
            })
        );
    }

    function recordOnggi(OnggiInput calldata o) external {
        traditions.push(
            OnggiTradition({
                vesselName: o.vesselName,
                region: o.region,
                materials: o.materials,
                techniques: o.techniques,
                functionalProperties: o.functionalProperties,
                culturalContext: o.culturalContext,
                uniqueness: o.uniqueness,
                creator: msg.sender,
                likes: 0,
                dislikes: 0,
                createdAt: block.timestamp
            })
        );

        emit OnggiRecorded(traditions.length - 1, o.vesselName, msg.sender);
    }

    function voteOnggi(uint256 id, bool like) external {
        require(id < traditions.length, "Invalid ID");
        require(!hasVoted[id][msg.sender], "Already voted");

        hasVoted[id][msg.sender] = true;
        OnggiTradition storage o = traditions[id];

        if (like) o.likes++;
        else o.dislikes++;

        emit OnggiVoted(id, like, o.likes, o.dislikes);
    }

    function totalOnggi() external view returns (uint256) {
        return traditions.length;
    }
}
