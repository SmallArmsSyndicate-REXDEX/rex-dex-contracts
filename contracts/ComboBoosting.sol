// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

import "./Boosting.sol";

contract ComboBoosting {
    function getCombo2(Boosting.SASInfo calldata info) external pure returns (uint) {
        if (
            keccak256(abi.encodePacked(info.head)) == keccak256(abi.encodePacked("Chameleon Head")) &&
            keccak256(abi.encodePacked(info.accessories)) == keccak256(abi.encodePacked("Chameleon Pet"))
        ) {
            return 1e12 * 5 / 100;
        }
        if (
            keccak256(abi.encodePacked(info.head)) == keccak256(abi.encodePacked("Colonial Wig")) &&
            keccak256(abi.encodePacked(info.clothes)) == keccak256(abi.encodePacked("Colonial Dress"))
        ) {
            return 1e12 * 5 / 100;
        }
        if (
            keccak256(abi.encodePacked(info.head)) == keccak256(abi.encodePacked("Army Helmet")) &&
            keccak256(abi.encodePacked(info.clothes)) == keccak256(abi.encodePacked("Army"))
        ) {
            return 1e12 * 5 / 100;
        }
        if (
            keccak256(abi.encodePacked(info.head)) == keccak256(abi.encodePacked("Big Crown")) &&
            keccak256(abi.encodePacked(info.clothes)) == keccak256(abi.encodePacked("Royal Cape"))
        ) {
            return 1e12 * 5 / 100;
        }
        if (
            keccak256(abi.encodePacked(info.head)) == keccak256(abi.encodePacked("Cowboy")) &&
            keccak256(abi.encodePacked(info.clothes)) == keccak256(abi.encodePacked("Long Coat"))
        ) {
            return 1e12 * 5 / 100;
        }
        if (
            keccak256(abi.encodePacked(info.head)) == keccak256(abi.encodePacked("Fire Crown")) &&
            keccak256(abi.encodePacked(info.eyes)) == keccak256(abi.encodePacked("Fire Eyes"))
        ) {
            return 1e12 * 5 / 100;
        }
        if (
            keccak256(abi.encodePacked(info.head)) == keccak256(abi.encodePacked("Halo")) &&
            keccak256(abi.encodePacked(info.clothes)) == keccak256(abi.encodePacked("Angel Outfit"))
        ) {
            return 1e12 * 5 / 100;
        }
        if (
            keccak256(abi.encodePacked(info.head)) == keccak256(abi.encodePacked("Kings Crown")) &&
            keccak256(abi.encodePacked(info.clothes)) == keccak256(abi.encodePacked("Royal Cape"))
        ) {
            return 1e12 * 5 / 100;
        }
        if (
            keccak256(abi.encodePacked(info.head)) == keccak256(abi.encodePacked("Viking Helmet")) &&
            keccak256(abi.encodePacked(info.clothes)) == keccak256(abi.encodePacked("Viking Dress"))
        ) {
            return 1e12 * 5 / 100;
        }
        if (
            keccak256(abi.encodePacked(info.head)) == keccak256(abi.encodePacked("Zookeeper Hat")) &&
            keccak256(abi.encodePacked(info.clothes)) == keccak256(abi.encodePacked("ZooKeeper Dress"))
        ) {
            return 1e12 * 5 / 100;
        }
        if (
            keccak256(abi.encodePacked(info.skins)) == keccak256(abi.encodePacked("Braveheart")) &&
            keccak256(abi.encodePacked(info.clothes)) == keccak256(abi.encodePacked("Braveheart"))
        ) {
            return 1e12 * 5 / 100;
        }
        if (
            keccak256(abi.encodePacked(info.head)) == keccak256(abi.encodePacked("Visor")) &&
            keccak256(abi.encodePacked(info.clothes)) == keccak256(abi.encodePacked("Popped Collar"))
        ) {
            return 1e12 * 5 / 100;
        }
        if (
            keccak256(abi.encodePacked(info.accessories)) == keccak256(abi.encodePacked("CAC Bud")) &&
            keccak256(abi.encodePacked(info.clothes)) == keccak256(abi.encodePacked("CAC Hoodie"))
        ) {
            return 1e12 * 5 / 100;
        }
        if (
            keccak256(abi.encodePacked(info.accessories)) == keccak256(abi.encodePacked("CAC Bud")) &&
            keccak256(abi.encodePacked(info.eyes)) == keccak256(abi.encodePacked("CAC Eyes"))
        ) {
            return 1e12 * 5 / 100;
        }
        if (
            keccak256(abi.encodePacked(info.accessories)) == keccak256(abi.encodePacked("CAC Bud")) &&
            keccak256(abi.encodePacked(info.background)) == keccak256(abi.encodePacked("Desert"))
        ) {
            return 1e12 * 5 / 100;
        }
        if (
            keccak256(abi.encodePacked(info.accessories)) == keccak256(abi.encodePacked("CAC Bud")) &&
            keccak256(abi.encodePacked(info.head)) == keccak256(abi.encodePacked("CAC Head"))
        ) {
            return 1e12 * 5 / 100;
        }
        if (
            keccak256(abi.encodePacked(info.accessories)) == keccak256(abi.encodePacked("CAC Bud")) &&
            keccak256(abi.encodePacked(info.mouths)) == keccak256(abi.encodePacked("Buck Teeth"))
        ) {
            return 1e12 * 5 / 100;
        }
        if (
            keccak256(abi.encodePacked(info.clothes)) == keccak256(abi.encodePacked("CAC Hoodie")) &&
            keccak256(abi.encodePacked(info.background)) == keccak256(abi.encodePacked("Desert"))
        ) {
            return 1e12 * 5 / 100;
        }
        if (
            keccak256(abi.encodePacked(info.eyes)) == keccak256(abi.encodePacked("CAC Eyes")) &&
            keccak256(abi.encodePacked(info.background)) == keccak256(abi.encodePacked("Desert"))
        ) {
            return 1e12 * 5 / 100;
        }
        if (
            keccak256(abi.encodePacked(info.head)) == keccak256(abi.encodePacked("CAC Head")) &&
            keccak256(abi.encodePacked(info.background)) == keccak256(abi.encodePacked("Desert"))
        ) {
            return 1e12 * 5 / 100;
        }
        if (
            keccak256(abi.encodePacked(info.mouths)) == keccak256(abi.encodePacked("Buck Teeth")) &&
            keccak256(abi.encodePacked(info.background)) == keccak256(abi.encodePacked("Desert"))
        ) {
            return 1e12 * 5 / 100;
        }
        if (
            keccak256(abi.encodePacked(info.clothes)) == keccak256(abi.encodePacked("CAC Hoodie")) &&
            keccak256(abi.encodePacked(info.eyes)) == keccak256(abi.encodePacked("CAC Eyes"))
        ) {
            return 1e12 * 5 / 100;
        }
        if (
            keccak256(abi.encodePacked(info.clothes)) == keccak256(abi.encodePacked("CAC Hoodie")) &&
            keccak256(abi.encodePacked(info.head)) == keccak256(abi.encodePacked("CAC Head"))
        ) {
            return 1e12 * 5 / 100;
        }
        if (
            keccak256(abi.encodePacked(info.clothes)) == keccak256(abi.encodePacked("CAC Hoodie")) &&
            keccak256(abi.encodePacked(info.mouths)) == keccak256(abi.encodePacked("Buck Teeth"))
        ) {
            return 1e12 * 5 / 100;
        }
        if (
            keccak256(abi.encodePacked(info.eyes)) == keccak256(abi.encodePacked("CAC Eyes")) &&
            keccak256(abi.encodePacked(info.head)) == keccak256(abi.encodePacked("CAC Head"))
        ) {
            return 1e12 * 5 / 100;
        }
        if (
            keccak256(abi.encodePacked(info.eyes)) == keccak256(abi.encodePacked("CAC Eyes")) &&
            keccak256(abi.encodePacked(info.mouths)) == keccak256(abi.encodePacked("Buck Teeth"))
        ) {
            return 1e12 * 5 / 100;
        }
        if (
            keccak256(abi.encodePacked(info.head)) == keccak256(abi.encodePacked("CAC Head")) &&
            keccak256(abi.encodePacked(info.mouths)) == keccak256(abi.encodePacked("Buck Teeth"))
        ) {
            return 1e12 * 5 / 100;
        }
        if (
            keccak256(abi.encodePacked(info.accessories)) == keccak256(abi.encodePacked("CAC Slapper")) &&
            keccak256(abi.encodePacked(info.head)) == keccak256(abi.encodePacked("CAC Helmet"))
        ) {
            return 1e12 * 5 / 100;
        }
        if (
            keccak256(abi.encodePacked(info.accessories)) == keccak256(abi.encodePacked("CAC Slapper")) &&
            keccak256(abi.encodePacked(info.clothes)) == keccak256(abi.encodePacked("CAC Armor"))
        ) {
            return 1e12 * 5 / 100;
        }
        if (
            keccak256(abi.encodePacked(info.head)) == keccak256(abi.encodePacked("CAC Helmet")) &&
            keccak256(abi.encodePacked(info.clothes)) == keccak256(abi.encodePacked("CAC Armor"))
        ) {
            return 1e12 * 5 / 100;
        }
        if (
            keccak256(abi.encodePacked(info.accessories)) == keccak256(abi.encodePacked("Bat Throwing Knives")) &&
            keccak256(abi.encodePacked(info.background)) == keccak256(abi.encodePacked("City Skyline"))
        ) {
            return 1e12 * 5 / 100;
        }
        if (
            keccak256(abi.encodePacked(info.accessories)) == keccak256(abi.encodePacked("Bat Throwing Knives")) &&
            keccak256(abi.encodePacked(info.clothes)) == keccak256(abi.encodePacked("Bat Suit"))
        ) {
            return 1e12 * 5 / 100;
        }
        if (
            keccak256(abi.encodePacked(info.accessories)) == keccak256(abi.encodePacked("Bat Throwing Knives")) &&
            keccak256(abi.encodePacked(info.head)) == keccak256(abi.encodePacked("Bat Head"))
        ) {
            return 1e12 * 5 / 100;
        }
        if (
            keccak256(abi.encodePacked(info.background)) == keccak256(abi.encodePacked("City Skyline")) &&
            keccak256(abi.encodePacked(info.clothes)) == keccak256(abi.encodePacked("Bat Suit"))
        ) {
            return 1e12 * 5 / 100;
        }
        if (
            keccak256(abi.encodePacked(info.background)) == keccak256(abi.encodePacked("City Skyline")) &&
            keccak256(abi.encodePacked(info.head)) == keccak256(abi.encodePacked("Bat Head"))
        ) {
            return 1e12 * 5 / 100;
        }
        if (
            keccak256(abi.encodePacked(info.clothes)) == keccak256(abi.encodePacked("Bat Suit")) &&
            keccak256(abi.encodePacked(info.head)) == keccak256(abi.encodePacked("Bat Head"))
        ) {
            return 1e12 * 5 / 100;
        }
        if (
            keccak256(abi.encodePacked(info.head)) == keccak256(abi.encodePacked("Wandalorian Helmet")) &&
            keccak256(abi.encodePacked(info.background)) == keccak256(abi.encodePacked("Galaxy"))
        ) {
            return 1e12 * 5 / 100;
        }
        if (
            keccak256(abi.encodePacked(info.clothes)) == keccak256(abi.encodePacked("Wandalorian")) &&
            keccak256(abi.encodePacked(info.background)) == keccak256(abi.encodePacked("Galaxy"))
        ) {
            return 1e12 * 5 / 100;
        }
        if (
            keccak256(abi.encodePacked(info.clothes)) == keccak256(abi.encodePacked("Wandalorian")) &&
            keccak256(abi.encodePacked(info.head)) == keccak256(abi.encodePacked("Wandalorian Helmet"))
        ) {
            return 1e12 * 5 / 100;
        }
        if (
            keccak256(abi.encodePacked(info.head)) == keccak256(abi.encodePacked("Viking Braid")) &&
            keccak256(abi.encodePacked(info.clothes)) == keccak256(abi.encodePacked("Viking Dress"))
        ) {
            return 1e12 * 5 / 100;
        }
        if (
            keccak256(abi.encodePacked(info.head)) == keccak256(abi.encodePacked("Viking Helmet")) &&
            keccak256(abi.encodePacked(info.clothes)) == keccak256(abi.encodePacked("Viking Dress"))
        ) {
            return 1e12 * 5 / 100;
        }
        if (
            keccak256(abi.encodePacked(info.head)) == keccak256(abi.encodePacked("Knight Helmet")) &&
            keccak256(abi.encodePacked(info.clothes)) == keccak256(abi.encodePacked("Knight Armor"))
        ) {
            return 1e12 * 5 / 100;
        }
        if (
            keccak256(abi.encodePacked(info.head)) == keccak256(abi.encodePacked("Darth Vader Helmet")) &&
            keccak256(abi.encodePacked(info.clothes)) == keccak256(abi.encodePacked("Darth Vader Suit"))
        ) {
            return 1e12 * 5 / 100;
        }
        if (
            keccak256(abi.encodePacked(info.head)) == keccak256(abi.encodePacked("Darth Vader Helmet")) &&
            keccak256(abi.encodePacked(info.accessories)) == keccak256(abi.encodePacked("Red Lightsaber"))
        ) {
            return 1e12 * 5 / 100;
        }
        if (
            keccak256(abi.encodePacked(info.clothes)) == keccak256(abi.encodePacked("Darth Vader Suit")) &&
            keccak256(abi.encodePacked(info.accessories)) == keccak256(abi.encodePacked("Red Lightsaber"))
        ) {
            return 1e12 * 5 / 100;
        }
        if (
            keccak256(abi.encodePacked(info.clothes)) == keccak256(abi.encodePacked("Devil Tux")) &&
            keccak256(abi.encodePacked(info.accessories)) == keccak256(abi.encodePacked("Devil Trident"))
        ) {
            return 1e12 * 5 / 100;
        }
        if (
            keccak256(abi.encodePacked(info.head)) == keccak256(abi.encodePacked("Devil Horns")) &&
            keccak256(abi.encodePacked(info.accessories)) == keccak256(abi.encodePacked("Devil Trident"))
        ) {
            return 1e12 * 5 / 100;
        }
        if (
            keccak256(abi.encodePacked(info.head)) == keccak256(abi.encodePacked("Devil Horns")) &&
            keccak256(abi.encodePacked(info.clothes)) == keccak256(abi.encodePacked("Devil Tux"))
        ) {
            return 1e12 * 5 / 100;
        }
        if (
            keccak256(abi.encodePacked(info.head)) == keccak256(abi.encodePacked("Chameleon Head")) &&
            keccak256(abi.encodePacked(info.accessories)) == keccak256(abi.encodePacked("Chameleon Pet"))
        ) {
            return 1e12 * 5 / 100;
        }
        if (
            keccak256(abi.encodePacked(info.eyes)) == keccak256(abi.encodePacked("WC Eyes")) &&
            keccak256(abi.encodePacked(info.accessories)) == keccak256(abi.encodePacked("Chameleon Pet"))
        ) {
            return 1e12 * 5 / 100;
        }
        if (
            keccak256(abi.encodePacked(info.eyes)) == keccak256(abi.encodePacked("WC Eyes")) &&
            keccak256(abi.encodePacked(info.head)) == keccak256(abi.encodePacked("Chameleon Head"))
        ) {
            return 1e12 * 5 / 100;
        }
        if (
            keccak256(abi.encodePacked(info.accessories)) == keccak256(abi.encodePacked("Bone Axe")) &&
            keccak256(abi.encodePacked(info.clothes)) == keccak256(abi.encodePacked("Bone Armor"))
        ) {
            return 1e12 * 5 / 100;
        }
        if (
            keccak256(abi.encodePacked(info.accessories)) == keccak256(abi.encodePacked("Bone Axe")) &&
            keccak256(abi.encodePacked(info.head)) == keccak256(abi.encodePacked("Bone Helmet"))
        ) {
            return 1e12 * 5 / 100;
        }
        if (
            keccak256(abi.encodePacked(info.clothes)) == keccak256(abi.encodePacked("Bone Armor")) &&
            keccak256(abi.encodePacked(info.head)) == keccak256(abi.encodePacked("Bone Helmet"))
        ) {
            return 1e12 * 5 / 100;
        }
        if (
            keccak256(abi.encodePacked(info.clothes)) == keccak256(abi.encodePacked("Shirtless Chad")) &&
            keccak256(abi.encodePacked(info.accessories)) == keccak256(abi.encodePacked("Gold Chain"))
        ) {
            return 1e12 * 5 / 100;
        }
        if (
            keccak256(abi.encodePacked(info.clothes)) == keccak256(abi.encodePacked("Shirtless Chad")) &&
            keccak256(abi.encodePacked(info.accessories)) == keccak256(abi.encodePacked("ZooRena Gloves"))
        ) {
            return 1e12 * 5 / 100;
        }
        if (
            keccak256(abi.encodePacked(info.mouths)) == keccak256(abi.encodePacked("Gold Grill")) &&
            keccak256(abi.encodePacked(info.background)) == keccak256(abi.encodePacked("Golden Brick Wall"))
        ) {
            return 1e12 * 5 / 100;
        }
        if (
            keccak256(abi.encodePacked(info.skins)) == keccak256(abi.encodePacked("Gold")) &&
            keccak256(abi.encodePacked(info.mouths)) == keccak256(abi.encodePacked("Gold Grill"))
        ) {
            return 1e12 * 5 / 100;
        }
        if (
            keccak256(abi.encodePacked(info.skins)) == keccak256(abi.encodePacked("Gold")) &&
            keccak256(abi.encodePacked(info.background)) == keccak256(abi.encodePacked("Golden Brick Wall"))
        ) {
            return 1e12 * 5 / 100;
        }
        return 0;
    }

    function getCombo3(Boosting.SASInfo calldata info) external pure returns (uint) {
        if (
            keccak256(abi.encodePacked(info.head)) == keccak256(abi.encodePacked("Bat Head")) &&
            keccak256(abi.encodePacked(info.clothes)) == keccak256(abi.encodePacked("Bat Suit")) &&
            keccak256(abi.encodePacked(info.accessories)) == keccak256(abi.encodePacked("Bat Throwing Knives"))
        ) {
            return 1e12 * 10 / 100;
        }
        if (
            keccak256(abi.encodePacked(info.head)) == keccak256(abi.encodePacked("Bone Helmet")) &&
            keccak256(abi.encodePacked(info.clothes)) == keccak256(abi.encodePacked("Bone Armor")) &&
            keccak256(abi.encodePacked(info.accessories)) == keccak256(abi.encodePacked("Bone Axe"))
        ) {
            return 1e12 * 10 / 100;
        }
        if (
            keccak256(abi.encodePacked(info.head)) == keccak256(abi.encodePacked("CAC Helmet")) &&
            keccak256(abi.encodePacked(info.clothes)) == keccak256(abi.encodePacked("CAC Armor")) &&
            keccak256(abi.encodePacked(info.accessories)) == keccak256(abi.encodePacked("CAC Slapper"))
        ) {
            return 1e12 * 10 / 100;
        }
        if (
            keccak256(abi.encodePacked(info.accessories)) == keccak256(abi.encodePacked("CAC Bud")) &&
            keccak256(abi.encodePacked(info.background)) == keccak256(abi.encodePacked("Desert")) &&
            keccak256(abi.encodePacked(info.eyes)) == keccak256(abi.encodePacked("CAC Eyes"))
        ) {
            return 1e12 * 10 / 100;
        }
        if (
            keccak256(abi.encodePacked(info.accessories)) == keccak256(abi.encodePacked("CAC Bud")) &&
            keccak256(abi.encodePacked(info.background)) == keccak256(abi.encodePacked("Desert")) &&
            keccak256(abi.encodePacked(info.head)) == keccak256(abi.encodePacked("CAC Head"))
        ) {
            return 1e12 * 10 / 100;
        }
        if (
            keccak256(abi.encodePacked(info.accessories)) == keccak256(abi.encodePacked("CAC Bud")) &&
            keccak256(abi.encodePacked(info.background)) == keccak256(abi.encodePacked("Desert")) &&
            keccak256(abi.encodePacked(info.mouths)) == keccak256(abi.encodePacked("Buck Teeth"))
        ) {
            return 1e12 * 10 / 100;
        }
        if (
            keccak256(abi.encodePacked(info.background)) == keccak256(abi.encodePacked("Desert")) &&
            keccak256(abi.encodePacked(info.clothes)) == keccak256(abi.encodePacked("CAC Hoodie")) &&
            keccak256(abi.encodePacked(info.eyes)) == keccak256(abi.encodePacked("CAC Eyes"))
        ) {
            return 1e12 * 10 / 100;
        }
        if (
            keccak256(abi.encodePacked(info.clothes)) == keccak256(abi.encodePacked("CAC Hoodie")) &&
            keccak256(abi.encodePacked(info.eyes)) == keccak256(abi.encodePacked("CAC Eyes")) &&
            keccak256(abi.encodePacked(info.head)) == keccak256(abi.encodePacked("CAC Head"))
        ) {
            return 1e12 * 10 / 100;
        }
        if (
            keccak256(abi.encodePacked(info.eyes)) == keccak256(abi.encodePacked("CAC Eyes")) &&
            keccak256(abi.encodePacked(info.head)) == keccak256(abi.encodePacked("CAC Head")) &&
            keccak256(abi.encodePacked(info.mouths)) == keccak256(abi.encodePacked("Buck Teeth"))
        ) {
            return 1e12 * 10 / 100;
        }
        if (
            keccak256(abi.encodePacked(info.head)) == keccak256(abi.encodePacked("Chameleon Head")) &&
            keccak256(abi.encodePacked(info.eyes)) == keccak256(abi.encodePacked("WC Eyes")) &&
            keccak256(abi.encodePacked(info.accessories)) == keccak256(abi.encodePacked("Chameleon Pet"))
        ) {
            return 1e12 * 10 / 100;
        }
        if (
            keccak256(abi.encodePacked(info.clothes)) == keccak256(abi.encodePacked("Devil Tux")) &&
            keccak256(abi.encodePacked(info.head)) == keccak256(abi.encodePacked("Devil Horns")) &&
            keccak256(abi.encodePacked(info.accessories)) == keccak256(abi.encodePacked("Devil Trident"))
        ) {
            return 1e12 * 10 / 100;
        }
        if (
            keccak256(abi.encodePacked(info.clothes)) == keccak256(abi.encodePacked("Jedi Robe")) &&
            keccak256(abi.encodePacked(info.head)) == keccak256(abi.encodePacked("Jedi Hair")) &&
            keccak256(abi.encodePacked(info.accessories)) == keccak256(abi.encodePacked("Green LightSaber"))
        ) {
            return 1e12 * 10 / 100;
        }
        if (
            keccak256(abi.encodePacked(info.clothes)) == keccak256(abi.encodePacked("Joker Suit")) &&
            keccak256(abi.encodePacked(info.head)) == keccak256(abi.encodePacked("Joker Suit")) &&
            keccak256(abi.encodePacked(info.skins)) == keccak256(abi.encodePacked("Joker"))
        ) {
            return 1e12 * 10 / 100;
        }
        if (
            keccak256(abi.encodePacked(info.clothes)) == keccak256(abi.encodePacked("Tuxedo")) &&
            keccak256(abi.encodePacked(info.eyes)) == keccak256(abi.encodePacked("Money Eyes")) &&
            keccak256(abi.encodePacked(info.accessories)) == keccak256(abi.encodePacked("Money"))
        ) {
            return 1e12 * 10 / 100;
        }
        if (
            keccak256(abi.encodePacked(info.clothes)) == keccak256(abi.encodePacked("Jedi Robe")) &&
            keccak256(abi.encodePacked(info.head)) == keccak256(abi.encodePacked("Jedi Hair")) &&
            keccak256(abi.encodePacked(info.accessories)) == keccak256(abi.encodePacked("Purple LightSaber"))
        ) {
            return 1e12 * 10 / 100;
        }
        if (
            keccak256(abi.encodePacked(info.clothes)) == keccak256(abi.encodePacked("Jedi Robe")) &&
            keccak256(abi.encodePacked(info.head)) == keccak256(abi.encodePacked("Jedi Hair")) &&
            keccak256(abi.encodePacked(info.accessories)) == keccak256(abi.encodePacked("Red LightSaber"))
        ) {
            return 1e12 * 10 / 100;
        }
        if (
            keccak256(abi.encodePacked(info.clothes)) == keccak256(abi.encodePacked("Darth Vader Suit")) &&
            keccak256(abi.encodePacked(info.head)) == keccak256(abi.encodePacked("Darth Vader Helmet")) &&
            keccak256(abi.encodePacked(info.accessories)) == keccak256(abi.encodePacked("Red LightSaber"))
        ) {
            return 1e12 * 10 / 100;
        }
        if (
            keccak256(abi.encodePacked(info.clothes)) == keccak256(abi.encodePacked("Shirtless Chad")) &&
            keccak256(abi.encodePacked(info.accessories)) == keccak256(abi.encodePacked("Gold Chain")) &&
            keccak256(abi.encodePacked(info.background)) == keccak256(abi.encodePacked("Beach"))
        ) {
            return 1e12 * 10 / 100;
        }
        if (
            keccak256(abi.encodePacked(info.clothes)) == keccak256(abi.encodePacked("Knight Armor")) &&
            keccak256(abi.encodePacked(info.head)) == keccak256(abi.encodePacked("Knight Helmet")) &&
            keccak256(abi.encodePacked(info.accessories)) == keccak256(abi.encodePacked("Sword"))
        ) {
            return 1e12 * 10 / 100;
        }
        if (
            keccak256(abi.encodePacked(info.clothes)) == keccak256(abi.encodePacked("Angel Outfit")) &&
            keccak256(abi.encodePacked(info.head)) == keccak256(abi.encodePacked("Halo")) &&
            keccak256(abi.encodePacked(info.eyes)) == keccak256(abi.encodePacked("Heart"))
        ) {
            return 1e12 * 10 / 100;
        }
        if (
            keccak256(abi.encodePacked(info.clothes)) == keccak256(abi.encodePacked("Viking Dress")) &&
            keccak256(abi.encodePacked(info.head)) == keccak256(abi.encodePacked("Viking Braid")) &&
            keccak256(abi.encodePacked(info.accessories)) == keccak256(abi.encodePacked("Sword"))
        ) {
            return 1e12 * 10 / 100;
        }
        if (
            keccak256(abi.encodePacked(info.clothes)) == keccak256(abi.encodePacked("Wandalorian")) &&
            keccak256(abi.encodePacked(info.head)) == keccak256(abi.encodePacked("Wandalorian Helmet")) &&
            keccak256(abi.encodePacked(info.background)) == keccak256(abi.encodePacked("Galaxy"))
        ) {
            return 1e12 * 10 / 100;
        }
        if (
            keccak256(abi.encodePacked(info.clothes)) == keccak256(abi.encodePacked("Wandalorian")) &&
            keccak256(abi.encodePacked(info.head)) == keccak256(abi.encodePacked("Wandalorian Helmet")) &&
            keccak256(abi.encodePacked(info.accessories)) == keccak256(abi.encodePacked("Blaster"))
        ) {
            return 1e12 * 10 / 100;
        }
        
        return 0;
    }

    function getCombo4(Boosting.SASInfo calldata info) external pure returns (uint) {
        if (
            keccak256(abi.encodePacked(info.background)) == keccak256(abi.encodePacked("City Skyline")) &&
            keccak256(abi.encodePacked(info.clothes)) == keccak256(abi.encodePacked("Bat Suit")) &&
            keccak256(abi.encodePacked(info.accessories)) == keccak256(abi.encodePacked("Bat Throwing Knives")) &&
            keccak256(abi.encodePacked(info.head)) == keccak256(abi.encodePacked("Bat Head"))
        ) {
            return 1e12 * 20 / 100;
        }
        if (
            keccak256(abi.encodePacked(info.skins)) == keccak256(abi.encodePacked("Joker")) &&
            keccak256(abi.encodePacked(info.clothes)) == keccak256(abi.encodePacked("Joker Suit")) &&
            keccak256(abi.encodePacked(info.accessories)) == keccak256(abi.encodePacked("Joker Cards")) &&
            keccak256(abi.encodePacked(info.head)) == keccak256(abi.encodePacked("Joker Hair"))
        ) {
            return 1e12 * 20 / 100;
        }
        if (
            keccak256(abi.encodePacked(info.background)) == keccak256(abi.encodePacked("Black")) &&
            keccak256(abi.encodePacked(info.skins)) == keccak256(abi.encodePacked("Extinct")) &&
            keccak256(abi.encodePacked(info.mouths)) == keccak256(abi.encodePacked("Dead")) &&
            keccak256(abi.encodePacked(info.eyes)) == keccak256(abi.encodePacked("Empty"))
        ) {
            return 1e12 * 20 / 100;
        }
        if (
            keccak256(abi.encodePacked(info.background)) == keccak256(abi.encodePacked("Desert")) &&
            keccak256(abi.encodePacked(info.clothes)) == keccak256(abi.encodePacked("CAC Hoodie")) &&
            keccak256(abi.encodePacked(info.eyes)) == keccak256(abi.encodePacked("CAC Eyes")) &&
            keccak256(abi.encodePacked(info.head)) == keccak256(abi.encodePacked("CAC Head"))
        ) {
            return 1e12 * 20 / 100;
        }
        
        return 0;
    }

    function getCombo6(Boosting.SASInfo calldata info) external pure returns (uint) {
        if (
            keccak256(abi.encodePacked(info.background)) == keccak256(abi.encodePacked("Desert")) &&
            keccak256(abi.encodePacked(info.mouths)) == keccak256(abi.encodePacked("Buck Teeth")) &&
            keccak256(abi.encodePacked(info.eyes)) == keccak256(abi.encodePacked("CAC Eyes")) &&
            keccak256(abi.encodePacked(info.clothes)) == keccak256(abi.encodePacked("CAC Hoodie")) &&
            keccak256(abi.encodePacked(info.accessories)) == keccak256(abi.encodePacked("CAC Bud")) &&
            keccak256(abi.encodePacked(info.head)) == keccak256(abi.encodePacked("CAC Head"))
        ) {
            return 1e12 * 30 / 100; // 30%
        }
        return 0;
    }
}

