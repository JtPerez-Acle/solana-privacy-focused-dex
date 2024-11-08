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

### 6. Next Steps

**Implement Core Functionality:**

- **Smart Contracts**: Implement the logic for `place_order` and `add_liquidity` functions.
- **Privacy Layer**: Integrate a zk-SNARK library compatible with Solana, such as [Bulletproofs](https://crates.io/crates/bulletproofs).
- **Account Structures**: Define account data structures for users, orders, and liquidity pools.

**Expand Testing:**

- **Tests**: Add more unit tests covering different scenarios and edge cases.
- **Integration Tests**: Begin writing integration tests in `tests/integration_tests.rs`.

**Continuous Integration:**

- **CI Pipeline**: Set up a CI/CD pipeline using GitHub Actions to automate testing on each commit.

---

### 7. Example Implementation of `place_order`

Here's how we can start implementing the `place_order` function.

**Update `contracts/src/smart_contracts.rs`**

```rust:contracts/src/smart_contracts.rs
use anchor_lang::prelude::*;

#[account]
pub struct Order {
    pub user: Pubkey,
    pub amount: u64,
    pub price: u64,
    pub timestamp: i64,
}

pub fn place_order(ctx: Context<PlaceOrder>, amount: u64, price: u64) -> Result<()> {
    let order = &mut ctx.accounts.order;
    order.user = ctx.accounts.user.key();
    order.amount = amount;
    order.price = price;
    order.timestamp = Clock::get()?.unix_timestamp;
    Ok(())
}

#[derive(Accounts)]
pub struct PlaceOrder<'info> {
    #[account(init, payer = user, space = 8 + 32 + 8 + 8 + 8)]
    pub order: Account<'info, Order>,
    #[account(mut)]
    pub user: Signer<'info>,
    pub system_program: Program<'info, System>,
}
```

---

### 8. Update Tests Accordingly

**File: `tests/unit_tests.rs`**

```rust:tests/unit_tests.rs
#[tokio::test]
async fn test_place_order() {
    // ... Existing setup ...

    // Adjust transaction to include accounts
    let order_account = Keypair::new();

    let mut transaction = Transaction::new_with_payer(
        &[Instruction {
            program_id: privacy_dex::ID,
            accounts: vec![
                AccountMeta::new(order_account.pubkey(), false),
                AccountMeta::new(user.pubkey(), true),
                AccountMeta::new_readonly(solana_program::system_program::ID, false),
            ],
            data: privacy_dex::instruction::PlaceOrder { amount: 100, price: 50 }.data(),
        }],
        Some(&payer.pubkey()),
    );

    transaction.sign(&[&payer, &user, &order_account], recent_blockhash);

    // Send transaction and assert success
    assert!(banks_client.process_transaction(transaction).await.is_ok());

    // Fetch the order account to verify data
    let order_data = banks_client
        .get_account(order_account.pubkey())
        .await
        .unwrap()
        .expect("Order account not found");

    let order: Order = Order::try_from_slice(&order_data.data).unwrap();
    assert_eq!(order.amount, 100);
    assert_eq!(order.price, 50);
    assert_eq!(order.user, user.pubkey());
}
```

---

### 9. Setting Up Continuous Testing in CI

**GitHub Actions Workflow (`.github/workflows/ci.yml`)**

```yaml
name: CI

on:
  push:
    branches: [ main ]
  pull_request:
    branches: [ main ]

jobs:
  build-and-test:
    runs-on: ubuntu-latest

    steps:
      - uses: actions/checkout@v3

      - name: Set up Rust
        uses: actions/setup-rust@v1
        with:
          rust-version: '1.68.2'

      - name: Install Anchor
        run: |
          cargo install --git https://github.com/coral-xyz/anchor --tag v0.24.2 anchor-cli --locked

      - name: Build Contracts
        working-directory: contracts
        run: anchor build

      - name: Run Tests
        working-directory: contracts
        run: anchor test
```

---

### 10. Conclusion

By starting to implement the core functionalities and setting up testing, we ensure that our development aligns with the best practices outlined in `global.md`. Early testing facilitates:

- **Early Bug Detection**: Catch issues during development rather than later stages.
- **Code Quality**: Maintain high standards for code through continuous testing.
- **Modularity**: Encourage modular design by testing components individually.

---

Please let me know if you'd like to focus on a specific component or need further assistance with any part of the development process. 
