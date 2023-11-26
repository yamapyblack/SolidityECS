import {
  loadFixture,
  time,
} from "@nomicfoundation/hardhat-toolbox-viem/network-helpers";
import { expect } from "chai";
import hre from "hardhat";
import {
  getAddress,
  parseGwei,
  getFunctionSelector,
  encodePacked,
  stringToHex,
} from "viem";

describe("IncrementSystem", function () {
  async function deployFixture() {
    const [owner, alice] = await hre.viem.getWalletClients();

    const incrementSystem = await hre.viem.deployContract(
      "IncrementSystem",
      [],
    );
    const proxyContract = await hre.viem.deployContract("Proxy", []);

    const publicClient = await hre.viem.getPublicClient();

    return {
      incrementSystem,
      proxyContract,
      owner,
      alice,
      publicClient,
    };
  }

  describe("Tests", function () {
    it("SetFunctions", async function () {
      const { incrementSystem, proxyContract, owner, alice, publicClient } =
        await loadFixture(deployFixture);

      let selector: `0x${string}` = "0x";
      incrementSystem.abi.forEach((a) => {
        if (a.name == "increment") {
          console.log("========");
          console.log(a.name);
          // console.log(a.type);
          // console.log(a.stateMutability);
          selector = getFunctionSelector(a);
          console.log(selector);
          console.log("========");
        }
      });

      await proxyContract.write.setFunctions([
        selector,
        incrementSystem.address,
      ]);

      // Non-simulated but cannot retrieve the result

      // const hash = await owner.writeContract({
      //   address: proxyContract.address,
      //   abi: incrementSystem.abi,
      //   functionName: "increment",
      //   account: owner.account.address,
      // });

      const { request, result } = await publicClient.simulateContract({
        address: proxyContract.address,
        abi: incrementSystem.abi,
        functionName: "increment",
        account: owner.account.address,
      });
      await owner.writeContract(request);

      const { request: req2, result: res2 } =
        await publicClient.simulateContract({
          address: proxyContract.address,
          abi: incrementSystem.abi,
          functionName: "increment",
          account: owner.account.address,
        });
      await owner.writeContract(req2);

      console.log("count", res2);

      //retrieve value directly from proxy
      const _tableId = encodePacked(
        ["bytes16", "bytes16"],
        [stringToHex("", { size: 16 }), stringToHex("Counter", { size: 16 })],
      );
      const count2 = await proxyContract.read.getConfig([_tableId]);
      console.log("count2", count2);
    });
  });
});
