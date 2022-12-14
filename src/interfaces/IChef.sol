// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import "openzeppelin/token/ERC20/IERC20.sol";
import "openzeppelin/interfaces/IERC165.sol";
import "./ISteak.sol";

/**
 *
 * @title IChef
 * @author Joshua Oladeji <analogdev.eth>
 *
 */

interface IChef is IERC165 {
    event Deposit(address indexed id, uint256 amount);

    event Withdrawal(address indexed id, uint256 amount);

    event ClaimRewards(address indexed id, uint256 rewards);

    /// @notice Types of tracked transactions
    enum TransactionType {
        DEPOSIT,
        WITHDRAWAL
    }

    /// @notice Struct storing the info of a user (yield farmer)
    /// - id: Address of the user
    /// - capital: Amount of user's ERC20 tokens staked in this contract
    /// - cachedSteak: Cached pending rewards yet to be claimed by user
    /// - blockRewardIndex: Index of the last block in `_txBlocks[]` used to calculate user's steak rewards
    /// - untrackedRewardBlocks: Block numbers of harvests in blocks not tracked in `_txBlocks[]`
    struct User {
        address id;
        uint256 capital;
        uint256 cachedSteak;
        uint256 blockRewardIndex;
        uint256[] untrackedRewardBlocks;
    }

    function capitalToken() external view returns (IERC20);

    function steakToken() external view returns (ISteak);

    function protocolAddress() external view returns (address);

    function protocolShare() external view returns (uint96);

    function steakPerSecond() external view returns (uint256);

    function trackedCapital() external view returns (uint256);

    function getPendingSteak(address _user) external view returns (uint256);

    function getUser(address _id) external view returns (User memory);

    function deposit(uint256 _amount) external;

    function depositAndClaimRewards(uint256 _amount) external;

    function withdraw(uint256 _amount) external;

    function withdrawAndClaimRewards(uint256 _amount) external;

    function claimPendingSteak() external;

    function setProtocolAddress(address _protocolAddress) external;

    function setProtocolShare(uint96 _protocolShare) external;
}
