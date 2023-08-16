import ExpenseItem from "./ExpenseItem";

function Expenses(props) {
	const items = props.items;
	const expenseItems = items.map((item) => (
		<ExpenseItem
			key={item.id}
			title={item.title}
			amount={item.amount}
			date={item.date}
		></ExpenseItem>
	));

	return <div>{expenseItems}</div>;
}
export default Expenses;
