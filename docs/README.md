# --------! PROJECT UNDER DEVELOPMENT !--------

# Privacy-Focused DEX on Solana

## Building the Project

To build the smart contracts and frontend application, run:

```bash
./scripts/build.sh
```

## Running Tests

To run unit tests for the smart contracts, execute:

```bash
./scripts/test.sh
```

## Prerequisites

- **Rust and Cargo**: Install via [rustup](https://rustup.rs/)
- **Anchor CLI**: Install with:
  ```bash
  cargo install --git https://github.com/coral-xyz/anchor --tag v0.24.2 anchor-cli --locked
  ```
- **Node.js and npm**: Install from [nodejs.org](https://nodejs.org/)
- **Solana CLI**: Install from [solana.com](https://docs.solana.com/cli/install-solana-cli-tools)

## Directory Structure

- **contracts/**: Rust smart contracts using Anchor.
- **tests/**: Unit and integration tests.
- **scripts/**: Build and test scripts.
- **frontend/**: React application with TypeScript.
- **docs/**: Project documentation.

## Getting Started

Ensure all prerequisites are installed. Clone the repository and navigate to the project directory.

```bash
git clone https://github.com/yourusername/privacy-dex.git
cd privacy-dex
```

---

### Next Steps

**Implement Core Functionality:**

- **Smart Contracts**: Implement the logic for `place_order` and `add_liquidity` functions.
- **Privacy Layer**: Integrate a zk-SNARK library compatible with Solana, such as [Bulletproofs](https://crates.io/crates/bulletproofs).
- **Account Structures**: Define account data structures for users, orders, and liquidity pools.

**Expand Testing:**

- **Tests**: Add more unit tests covering different scenarios and edge cases.
- **Integration Tests**: Begin writing integration tests in `tests/integration_tests.rs`.

**Continuous Integration:**

- **CI Pipeline**: Set up a CI/CD pipeline using GitHub Actions to automate testing on each commit.



### Conclusion

By starting to implement the core functionalities and setting up testing, we ensure that our development aligns with the best practices outlined in `global.md`. Early testing facilitates:

- **Early Bug Detection**: Catch issues during development rather than later stages.
- **Code Quality**: Maintain high standards for code through continuous testing.
- **Modularity**: Encourage modular design by testing components individually.

---
