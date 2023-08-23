import ExpenseItem from "./ExpenseItem";
import "./Expenses.css";
import Card from "../UI/Card";

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

	return <Card className="expenses">{expenseItems}</Card>;
}
export default Expenses;
